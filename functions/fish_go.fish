function fish_go -d "fish helper for go"

  set -gx GOPATH (go env GOPATH)

  set -gx GOBIN "$HOME/.go/bin"

  if test -d "$GOBIN"
     if not contains "$GOBIN" $PATH
       fish_add_path "$GOBIN"
     end
  end

end
