function codex-openrouter-infra-local
    set prompt (cat ~/.config/fish/codex/prompts/tf-local.txt)
    codex --profile openrouter-infra-local "$prompt" $argv
end

function codex-openrouter-infra-cloud
    set prompt (cat ~/.config/fish/codex/prompts/tf-cloud.txt)
    codex --profile openrouter-infra-cloud "$prompt" $argv
end
