#!/usr/bin/python
import platform
import os
import shutil
import tarfile
import tempfile
from collections.abc import Generator
from contextlib import contextmanager
from pathlib import Path

import requests
from ansible.module_utils.basic import AnsibleModule


def github_release_downloader(repo: str) -> list[str]:
    os = platform.system().lower()
    arch = platform.machine().lower()

    r = requests.get(f"https://api.github.com/repos/{repo}/releases/latest")
    downloads = []
    for asset in r.json()["assets"]:
        url = asset["browser_download_url"]
        # Check OS and architecture
        name = asset["name"].lower()
        if os in name and arch in name:
            downloads.append(url)
    return downloads


@contextmanager
def download_file(url: str) -> Generator[str, None, None]:
    tmp = tempfile.NamedTemporaryFile(mode="wb")
    try:
        with requests.get(url, stream=True) as r:
            r.raise_for_status()
            for chunk in r.iter_content(chunk_size=8192): 
                tmp.write(chunk)
        tmp.flush()
        yield tmp.name
    finally:
        tmp.close()


def install_binary(binary: str, path: str, url: str):
    with download_file(url) as f:
        if url.endswith("tar.gz"):
            extract_tar(f, binary, path)
        else:
            copy_binary(f, binary, path)


def extract_tar(file: str, binary: str, path: str):
    tar = tarfile.open(file)
    tar.extract(binary, path=path)
    tar.close()


def copy_binary(file: str, binary: str, path: str):
    shutil.copyfile(file, os.path.join(path, binary))
    os.chmod(os.path.join(path, binary), 0o755)


def main():
    spec = {
        "repo": {"required": True, "type": "str"},
        "install_path": {"required": True, "type": "str"},
        "binary": {"required": True, "type": "str"},
    }
    mod = AnsibleModule(argument_spec=spec)
    repo = mod.params["repo"]
    install_path = mod.params["install_path"]
    binary = mod.params["binary"]

    path = Path(os.path.join(install_path, binary))
    if path.is_file():
        mod.exit_json(changed=False, meta={"message": "already installed"})
        return

    urls = github_release_downloader(repo)
    if len(urls) == 0:
        mod.exit_json(changed=False, meta={"message": "no releases found for arch/os"})
        return
    install_binary(binary, install_path, urls[0])
    mod.exit_json(changed=True, meta={"files": urls})

if __name__ == '__main__':
    main()
