function take -d "make dir and cd"
    if test (count $argv) != 1
        echo "expected one argument"
    else
        mkdir -p -- $argv[1] && cd $argv[1]
    end
end
