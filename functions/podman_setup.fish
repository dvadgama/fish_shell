function podman_setup --description "Configure Podman Docker API socket"
    if not podman machine info >/dev/null 2>&1
        echo "🟡 Podman VM not running. Starting..."
        podman machine start >/dev/null
    end

    set -l sock_path (podman machine inspect --format '{{.ConnectionInfo.PodmanSocket.Path}}' 2>/dev/null)

    if test -S $sock_path
        # Export DOCKER_HOST globally
        set -gx DOCKER_HOST "unix://$sock_path"
        alias docker=podman
        echo "🐳 Podman Docker API socket active"
    else
        echo "⚠️  Podman socket not found or failed to inspect."
    end
end
