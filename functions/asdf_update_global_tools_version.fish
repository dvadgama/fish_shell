function asdf_update_global_tool_version --description 'Update version in ~/.tool-versions'
    set plugin $argv[1]
    set new_version $argv[2]
    set toolfile "$HOME/.tool-versions"

    # If plugin exists, replace line; else append
    if grep -q "^$plugin " $toolfile
        # Replace the line
        sed -i '' "s/^$plugin .*/$plugin $new_version/" $toolfile
    else
        echo "$plugin $new_version" >> $toolfile
    end
end
