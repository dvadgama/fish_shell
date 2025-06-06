function asdf_check_updates
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

        if not asdf plugin list | grep -q "^$plugin\$"
            echo "⚠️  Plugin '$plugin' not installed — skipping"
            continue
        end

        # Use plugin-specific semver filtering
        switch $plugin
          case python
            set latest_version (asdf list all $plugin | string trim | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | tail -1)
          case dart flutter golang nodejs kubectl minikube helm uv
            set latest_version (asdf list all $plugin | string trim | grep -E '^[0-9]+\.[0-9]+\.[0-9]+(-stable)?$' | tail -1)
          case java
            set latest_version (asdf list all $plugin | string trim | grep '^openjdk-' | tail -1)
          case '*'
            set latest_version (asdf list all $plugin | string trim | grep -v '^$' | tail -1)
        end

        if test -z "$latest_version"
            echo "❓ $plugin: Could not determine latest version"
            continue
        end

        if test "$current_version" = "$latest_version"
            echo "✅ $plugin is up to date ($current_version)"
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
    else
        echo ""
        echo "✅ All ASDF tools are latest stable"
    end

    return $update_count
end
