function wt -d "Display work log (default: last day)"
    if count $argv > /dev/null
        set days = $argv
    else
        set days = 1
    end

    task end.after:today-$days report.list.columns=end completed
end
