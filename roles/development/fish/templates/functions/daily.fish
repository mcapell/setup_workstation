function daily -d "TW information for daily"
    if count $argv > /dev/null
        set days $argv[1]
    else
        set days 1
    end

    echo "Completed during past $days days:"
    echo "-----------------------------"
    set twArgs rc.report.completed.sort=end- rc.report.completed.columns=uuid.short,end,tags,description rc.report.completed.labels=UUID,Completed,Tags,Description
    task $twArgs end.after:today-"$days"d completed 2> /dev/null

    echo ""
    echo "Working on:"
    echo "-----------"
    task 2> /dev/null
end
