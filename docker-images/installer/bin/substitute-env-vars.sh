#!/bin/bash

set -eu

output_dir=$1
shift
files=$@

function fill_in() {
    perl -p -e 's/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : "\${$1}"/eg' "${1}"
}

function output_filename {
    local destname=$(basename "${1}" '.tmpl')
    echo "${output_dir}/${destname}"
}

for file in $files; do
    fill_in "${file}" > $(output_filename "${file}")
done