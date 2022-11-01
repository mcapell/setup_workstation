function myprs -d "List my open PRs"
    if count $argv > /dev/null
        set filter "github.com/$argv[1]"
    else
        set filter "github.com/"
    end
    gh api graphql -f query='query { viewer { pullRequests(first: 100, states: OPEN, orderBy: {field: UPDATED_AT, direction: DESC}) { nodes { number, title, url } } } }' --template '{{range .data.viewer.pullRequests.nodes}}{{"#" | color "yellow" }}{{.number | color "yellow"}}{{"|"}}{{.url | color "cyan"}}{{"|"}}{{.title}}{{"\n"}}{{end}}' | column -t -s "|" | grep --colour=never $filter
end
