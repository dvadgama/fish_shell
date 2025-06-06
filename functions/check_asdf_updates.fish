function check_asdf_updates

    set tool_versions_file "$HOME/.tool-versions"
    if not test -f $tool_versions_file
        return 0
    end

    set update_count 0
    echo ""
    echo "🔍 Checking for ASDF tool updates..."

    for line in (cat $tool_versions_file)
        set parts (string split " " $line)
        set plugin $parts[1]
        set current_version $parts[2]

        # Handle errors if plugin not installed
        if not asdf plugin list | grep -q "^$plugin\$"
            echo "⚠️  Plugin '$plugin' not installed — skipping"
            continue
        end

        # Get latest non-empty version
        set all_versions (asdf list all $plugin | string trim | grep -v '^$')
        set latest_version (echo $all_versions | string split " " | tail -1)

        if test -z "$latest_version"
            echo "❓ $plugin: Could not determine latest version"
            continue
        end

        if test "$current_version" = "$latest_version"
            continue
        else
            set update_count (math $update_count + 1)
            echo "⬆️  $plugin: $current_version → $latest_version"
        end
    end

    if test $update_count -gt 0
        echo ""
        echo "🚨 $update_count ASDF tools have updates!"
        echo "🔧 Run: asdf install [tool] [version] to update"
        echo ""
    end
    
    return $update_count
end

