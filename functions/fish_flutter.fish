 set -gx FLUTTER_ROOT (asdf where flutter)
 set -gx DART_ROOT (asdf where dart)

 set -l pub_cache_bin "$HOME/.pub-cache/bin"

 if test -d "$pub_cache_bin"
    if not contains "$pub_cache_bin" $PATH
      fish_add_path "$pub_cache_bin"
    end
 end
