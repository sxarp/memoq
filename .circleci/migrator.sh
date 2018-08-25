#!/bin/bash
set -euxoC pipefail

function get_running_backend_pod(){
    local -r image_name="$1"
    kubectl get po -l app==backend --field-selector=status.phase=Running -o=json \
        | jq -r '.items| .[] | select( .spec.containers[0].image == "'"$image_name"'") | .metadata.name'
}

function exec_migration_to_pod(){
    local -r pod_name="$1"
    kubectl exec "$pod_name" --container backend -- /bin/sh -c \
            'cd /app && bundle exec ridgepole -c config/database.yml --apply -E staging -f db/Schemafile'
}

function exec_migration(){
    local -r number_of_iters="$1"
    local -r interval_for_each_iter="$2"
    local -r image_name="$3"

    for i in `seq 1 $number_of_iters`; do
        local pod="$(get_running_backend_pod "$image_name")"
        if [[ "$pod" != "" ]]; then
            exec_migration_to_pod "$pod"
            exit 0;
        fi
        echo "Waiting for pods with image: ${image_name} get readly to execute migration..."
        sleep "$interval_for_each_iter"
    done

    exit 1
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    exec_migration 10 5 "$1"
fi
