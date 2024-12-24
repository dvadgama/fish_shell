
function __set_fish_git_prompt_options
  #Options
  set -g __fish_git_prompt_show_informative_status yes
  set -g __fish_git_prompt_showcolorhints yes
  set -g __fish_git_prompt_showupstream verbose
  set -g __fish_git_prompt_showdirtystate yes
  set -g __fish_git_prompt_showuntrackedfiles yes 
  # Colors
  set green (set_color green)
  set magenta (set_color magenta)
  set normal (set_color normal)
  set red (set_color red)
  set yellow (set_color yellow)
  set -g __fish_git_prompt_color_branch magenta --bold
  set -g __fish_git_prompt_color_dirtystate white
  set -g __fish_git_prompt_color_invalidstate red
  set -g __fish_git_prompt_color_merging yellow
  set -g __fish_git_prompt_color_stagedstate yellow
  set -g __fish_git_prompt_color_upstream_ahead green
  set -g __fish_git_prompt_color_upstream_behind red
  # Icons
  set -g __fish_git_prompt_char_cleanstate ' 👍 '
  set -g __fish_git_prompt_char_conflictedstate ' ⚠️ '
  set -g __fish_git_prompt_char_dirtystate ' 💩 '
  set -g __fish_git_prompt_char_invalidstate ' 🤮 '
  set -g __fish_git_prompt_char_stagedstate ' 🚥 '
  set -g __fish_git_prompt_char_stashstate ' 📦 '
  set -g __fish_git_prompt_char_stateseparator ' |'
  set -g __fish_git_prompt_char_untrackedfiles ' 🔍 '
  set -g __fish_git_prompt_char_upstream_ahead ' ☝️ '
  set -g  __fish_git_prompt_char_upstream_behind ' 👇 '
  set -g __fish_git_prompt_char_upstream_diverged ' 🚧 '
  set -g __fish_git_prompt_char_upstream_equal ' 💯 ' 

end 

function fish_git_prompt_options
  if command -q git
    __set_fish_git_prompt_options
  end
end

fish_git_prompt_options