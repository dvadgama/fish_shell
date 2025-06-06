if status is-interactive
        # Commands to run in interactive sessions can go here
        set --erase fish_greeting
        fish_tools
        fish_ssh_agent
        fish_prompt
        fish_k8
        fish_flutter
        if command -q podman
          alias docker=podman
        end
	if command -q asdf
	  show_asdf_update
	end
end
