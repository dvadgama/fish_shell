function brew_monthly_update --description "Auto update Homebrew once a month"
    set stamp_file "$HOME/.cache/.brew_update_stamp"
    set month_id (date "+%Y-%m")

    if test -f $stamp_file
        if string match -q $month_id (cat $stamp_file)
            return 0
        end
    end

    echo $month_id > $stamp_file

    echo ""
    echo "🍺 Starting monthly Homebrew update for $month_id"
    echo ""

    brew update

    echo ""
    echo "🔍 Checking for outdated packages..."
    set outdated (brew outdated)

    if test (count $outdated) -eq 0
        echo "✅ All packages are up to date!"
    else
        for pkg in $outdated
            echo "⬆️  Upgrading: $pkg"
            brew upgrade $pkg
        end

        echo ""
        echo "✅ Homebrew packages updated."
    end

    echo ""
end