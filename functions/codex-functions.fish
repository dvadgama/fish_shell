function codex-openrouter-plan-infra-local
    set prompt (cat ~/.config/fish/codex/prompts/plan-tf-local.txt)
    codex --profile openrouter-plan "$prompt" $argv
end

function codex-openrouter-plan-infra-cloud
    set prompt (cat ~/.config/fish/codex/prompts/plan-tf-cloud.txt)
    codex --profile openrouter-plan "$prompt" $argv
end

function codex-openrouter-code-infra
    set prompt (cat ~/.config/fish/codex/prompts/code-tf.txt)
    codex --profile openrouter-code "$prompt" $argv
end

function codex-plan-infra-local
    set prompt (cat ~/.config/fish/codex/prompts/plan-tf-local.txt)
    codex --profile plan "$prompt" $argv
end

function codex-plan-infa-cloud
    set prompt (cat ~/.config/fish/codex/prompts/plan-tf-cloud.txt)
    codex --profile plan "$prompt" $argv
end

function codex-code-infra
    set prompt (cat ~/.config/fish/codex/prompts/code-tf.txt)
    codex --profile code "$prompt" $argv
end

function codex-ollama-code-infra
    set prompt (cat ~/.config/fish/codex/prompts/code-tf.txt)
    codex --profile ollama-code "$prompt" $argv
end
