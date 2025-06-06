function show_asdf_update
    set stamp_file "$HOME/.cache/.asdf_check_stamp"
    set today (date "+%d-%m-%Y")

    if not test -f "$stamp_file" || not string match -q "$today" (cat "$stamp_file")
        echo "$today" > "$stamp_file"

        check_asdf_updates >/dev/null 2>&1
        set outdated_count $status

        if test "$outdated_count" -gt 0
            echo ""
            echo "🚨 $outdated_count ASDF tools have updates!"
            echo "🔧 Run: check_asdf_updates"
            echo ""
        end
    end
end
