function asdf_clean_old_versions --description "Remove old ASDF versions, keeping only the current global version"
    set toolfile "$HOME/.tool-versions"

    if not test -f $toolfile
        echo "❌ No .tool-versions file found."
        return 1
    end

    for line in (cat $toolfile)
        set parts (string split " " $line)
        set plugin $parts[1]
        set current_version $parts[2]

        if not asdf plugin list | grep -q "^$plugin\$"
            continue
        end

        set removed 0

        # Clean and normalize installed version list
        for v in (asdf list $plugin | string trim | string replace -r '^\*' '' | string trim)
            if test "$v" != "$current_version"
                if test $removed -eq 0
                    echo ""
                    echo "🔧 Cleaning $plugin (keeping $current_version)"
                end

                echo "🗑 Removing $plugin $v"
                asdf uninstall $plugin $v
                set removed 1
            end
        end
    end

    if test $removed -eq 1
        echo ""
        echo "✅ Cleanup complete."
    else 
        echo ""
        echo "✅ Nothing to clean"
    end

end