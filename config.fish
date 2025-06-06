set --erase fish_greeting

if status is-interactive
  # Commands to run in interactive sessions can go here
  fish_tools
  fish_ssh_agent
  fish_prompt
  fish_k8
  fish_flutter
  brew_monthly_update
  if command -q podman
    alias docker=podman
  end
	if command -q asdf
	  asdf_show_updates_count
	end
end
