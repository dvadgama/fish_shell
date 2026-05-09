functions -e fish_greeting
set -U fish_greeting ""
set --erase fish_greeting

if status is-interactive
    alias cc-pr='codex --profile plan-review'
    alias cc-pl='codex --profile plan-local'
    alias cc-cl='codex --profile code-local'
    alias cc-cr='codex --profile code-review'

    fish_prompt
    fish_ssh_agent
    fish_k8
    fish_flutter
    brew_monthly_update
    fish_go
    # if command -q podman
    #     podman_setup
    # end

    if command -q asdf
        source (brew --prefix asdf)/share/fish/vendor_completions.d/asdf.fish 
        asdf_show_updates_count
    end

    if test -d /opt/homebrew/bin/
        fish_add_path /opt/homebrew/bin/
    end

    source "$HOME/.config/fish/functions/codex-functions.fish"
end
