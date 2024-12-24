
function fish_k8 -d "set kubectl alias and completion if command found"

  if command -q kubectl
    set k8_completion_file $HOME/.config/fish/completions/kubectl.fish
    if not test -f $k8_completion_file
      kubectl completion fish > $k8_completion_file
    end
    source $k8_completion_file
    set -e k8_completion_file
    alias k kubectl
    alias kgc "kubectl config get-contexts -o name"
  end
end