functions -e fish_greeting
set -U fish_greeting ""
set --erase fish_greeting

if status is-interactive
    fish_prompt
    fish_ssh_agent
    fish_k8
    fish_flutter
    brew_monthly_update
    if command -q podman
        podman_setup
    end

    if command -q asdf
        asdf_show_updates_count
    end

    if test -d /opt/homebrew/bin/
        fish_add_path /opt/homebrew/bin/
    end

end
