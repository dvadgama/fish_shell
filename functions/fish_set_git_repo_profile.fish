function fish_set_git_repo_profile
    set -l config_file "$HOME/.gitprofile.json"
    set -l profile_name $argv[1]

    # Ensure a profile name is provided
    if test -z "$profile_name"
        echo "Error: Profile name not provided!"
        return 1
    end

    # Ensure the config file exists
    if not test -f "$config_file"
        echo "Error: Config file '$config_file' does not exist!"
        return 1
    end

    # Ensure we are inside a Git repository
    if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
        echo "Error: Not inside a Git repository!"
        return 1
    end

    # Extract values from JSON for the specified profile
    set -l user_name (jq -r ".profiles.\"$profile_name\".user.name" $config_file)
    set -l user_email (jq -r ".profiles.\"$profile_name\".user.email" $config_file)
    set -l signing_key (jq -r ".profiles.\"$profile_name\".signing_key" $config_file)

    # Check if the profile exists and has required fields
    if test -z "$user_name" -o "$user_name" = "null" -o -z "$user_email" -o "$user_email" = "null"
        echo "Error: Profile '$profile_name' not found or missing required fields!"
        return 1
    end

    # Apply Git configurations locally for this repository
    git config --local user.name "$user_name"
    git config --local user.email "$user_email"
    echo "✔ Git user.name set to: $user_name"
    echo "✔ Git user.email set to: $user_email"

    # Check and set the signing key if available
    if test -n "$signing_key" -a "$signing_key" != "null"
        if test -f "$signing_key"
            git config --local user.signingkey "$signing_key"
            echo "✔ Git signing key set to: $signing_key"
        else
            echo "Error: Signing key file does not exist at $signing_key"
            return 1
        end
    else
        echo "ℹ No signing key specified for profile '$profile_name'. Skipping signing key setup."
    end

    echo "🎉 Git profile '$profile_name' successfully applied!"
end
