
function fish_tools -d "add binaries to path"
    # specifically added for KinD at this stage
    if test -d $HOME/go/bin 
        fish_add_path $HOME/go/bin
    end

    if test -d $HOME/.krew/bin
        fish_add_path $HOME/.krew/bin
    end    
end
