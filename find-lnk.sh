#!/bin/bash

if [[ -f "${1}" ]]; then
    echo First argument must be the root folder
    exit 1
fi

ROOT_FOLDER="${1}"
EXPECTED_SIGNATURE="4c0000000114020000000000c000000000000046"

find "${ROOT_FOLDER}" -type f | while read -r FILE; do
    SIGNATURE=$(xxd -p -l 20 "${FILE}" 2> /dev/null)

    # If nothing was read (empty file or unreadable), skip it
    if [[ -z "${SIGNATURE}" ]]; then
        continue
    fi

    if [[ "${SIGNATURE}" == "${EXPECTED_SIGNATURE}" ]]; then
        echo "${FILE} is a lnk file !"
    elif [[ "${SIGNATURE:0:8}" == "4c000000" ]]; then
        echo "${FILE} may be an lnk file..."
    fi
done
