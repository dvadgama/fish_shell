function __fish_status_info --description "send last status info"
    set known_exit_status $argv[1]
    set opening_bracket '['
    set closing_bracket ']'
    set status_ok ✔️
    set status_not_ok 💀
    if test $known_exit_status -eq 0
      printf '%s%s %s' $opening_bracket $status_ok $closing_bracket
    else
      printf '%s%s' $opening_bracket $status_not_ok
      set_color red
      printf ':%s' $known_exit_status
      set_color normal
      printf '%s' $closing_bracket
    end
  
end

function fish_prompt
    if [ (uname) != "Darwin" ]
      printf 'ubuntu@%s' $hostname
    end  
    __fish_status_info $status
  
    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal
    printf '%s' (__fish_git_prompt)
    #printf 🐬
    #printf "<🐠>"
    set_color normal
end
