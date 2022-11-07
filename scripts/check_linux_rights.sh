#!/usr/bin/env bash

function validate_root_access_rights() {
    if (($EUID != 0)); then
        if [[ -t 1 ]]; then
            sudo "$0" "$@"
        else
            exec 1>output_file
            gksu "$0 $@"
        fi
        exit
    fi
}
