function asdf_install_updates --description 'Auto-update ASDF tools, with optional plugin filter/exclude and dry-run support'
    set tool_versions_file "$HOME/.tool-versions"
    if not test -f $tool_versions_file
        echo "❌ No .tool-versions file found."
        return 1
    end

    set exclude_plugins
    set include_plugins
    set dry_run 0
    set parsing_excludes 0

    # Parse arguments
    for arg in $argv
        if test $arg = "--exclude"
            set parsing_excludes 1
            continue
        else if test $arg = "--dry-run"
            set dry_run 1
            continue
        end

        if test $parsing_excludes -eq 1
            set exclude_plugins $exclude_plugins $arg
        else
            set include_plugins $include_plugins $arg
        end
    end

    echo ""
    if test $dry_run -eq 1
        echo "🧪 DRY RUN: Showing what would be updated..."
    else
        echo "🔄 Checking and updating ASDF tools..."
    end

    for line in (cat $tool_versions_file)
        set parts (string split " " $line)
        set plugin $parts[1]
        set current_version $parts[2]

        if contains $plugin $exclude_plugins
            echo "🚫 Skipping excluded plugin: $plugin"
            continue
        end

        if test (count $include_plugins) -gt 0
            if not contains $plugin $include_plugins
                continue
            end
        end

        if not asdf plugin list | grep -q "^$plugin\$"
            echo "⚠️  Plugin '$plugin' not installed — skipping"
            continue
        end

        # Filtering logic from check_asdf_updates
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
        else
            if test $dry_run -eq 1
                echo "🔍 $plugin: $current_version → $latest_version (dry-run)"
            else
                echo "⬆️  Updating $plugin: $current_version → $latest_version"
		        asdf_update_global_tools_version $plugin $latest_version
                asdf install $plugin $latest_version
            end
        end
    end

    if test $dry_run -eq 1
        echo ""
        echo "✅ Dry run complete. No changes were made."
    else
        echo ""
        echo "Removing older versions"
        asdf_clean_old_versions
        echo ""
        echo "✅ ASDF tool updates complete."
    end
end
