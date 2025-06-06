function asdf_show_updates_count
    set stamp_file "$HOME/.cache/.asdf_check_stamp"
    set today (date "+%d-%m-%Y")

    if not test -f "$stamp_file" || not string match -q "$today" (cat "$stamp_file")
        echo "$today" > "$stamp_file"

        asdf_check_updates >/dev/null 2>&1
        set outdated_count $status

        if test "$outdated_count" -gt 0
            echo ""
            echo "🚨 $outdated_count ASDF tools have updates!"
            echo "🔧 Run: asdf_install_updates"
            echo ""
        else 
            echo ""
            echo "✅ All ASDF tools are latest stable"
        end
    end
end
