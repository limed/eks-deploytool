#!/bin/bash

set -eo pipefail

CHECKMARK="\xE2\x9C\x94"
SKULL="\xE2\x98\xA0"
XMARK="\xE2\x9D\x8C"

BASEDIR=$(pwd)
DEPLOY_FOLDER="${DEPLOY_FOLDER:-deploy}"
METADATA_FILE="${DEPLOY_FOLDER}/metadata.yaml"

print_ok() {
    local msg=$1
    echo -e "${CHECKMARK}  ${msg}"
}

print_fail() {
    local msg=$1
    echo -e "${SKULL}  ${msg}"
}

die() {
    print_fail "${1}"
    exit 1
}

get_kubeconfig() {
    local cluster_name="$1"
    local aws_region="${AWS_REGION:-us-west-2}"

    # shellcheck disable=SC2128
    if [ -z "${cluster_name}" ]; then die "Usage: ${FUNCNAME} <cluster name>"; fi
    aws eks update-kubeconfig --region "${aws_region}" --name "${cluster_name}" --alias "${cluster_name}" --kubeconfig "/${cluster_name}.config"
    rv=$?

    return "${rv}"
}

get_cluster_name() {
    local environment_file=$1
    if [ ! -f "${environment_file}" ]; then
        die "Can't find environment file"
    fi

    k8s_cluster=$(yq . "${environment_file}" | jq -r .k8s_cluster)
    if [ "${k8s_cluster}" == 'null' ]; then
        return 1
    else
        echo "${k8s_cluster}"
    fi
}

get_namespace(){
    local environment_file=$1
    if [ ! -f "${environment_file}" ]; then
        die "Can't find environment file"
    fi

    namespace=$(yq . "${environment_file}" | jq -r .namespace)
    if [ "${namespace}" == 'null' ]; then
        return 1
    else
        echo "${namespace}"
    fi
}

get_array() {
    local environment_file=$1
    local array_key=$2

    # shellcheck disable=SC2128
    if [ -z "${environment_file}" ] || [ -z "${array_key}" ]; then die "Usage: ${FUNCNAME} <environment file> <search string>"; fi

    if [ ! -f "${environment_file}" ]; then
        die "Can't find environment file"
    fi

    output_array=$(yq . "${environment_file}" | jq -e -c -r ".${array_key}[]?")
    rv=$?
    if [ -z "${output_array}" ] || [ "${rv}" -ne 0 ]; then
        return "${rv}"
    else
        echo "${output_array}"
    fi
}
