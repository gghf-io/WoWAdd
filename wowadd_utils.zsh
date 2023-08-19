#!/usr/bin/zsh

function wowadd_help() {
    echo "Usage: wowadd [OPTION]...[FILEPATH | FILEPATH...]"
    echo "INFO: The ADDON_NAME = \e[1;31m$ADDON_NAME\e[0m is retrieved with the name of the current folder"
    echo "OPTION:"
    echo "      --all                               Install files and directories in the addon folder"
    echo "      --one                               Install one file or directorie in the addon folder"
    echo "      --mt                                Install many files and directories in the addon folder"
    echo "      --help                              Open the helper"
    exit 0
}

function get_addon_name() {

    local addon_dir="$(pwd)"
    local addon_dir_parts=(${(@s:/:)addon_dir})
    local addon_dir_parts_len=${#addon_dir_parts[@]}
    local addon_name=$addon_dir_parts[$addon_dir_parts_len]

    echo $addon_name
    return $addon_name
}

ADDON_NAME="$(get_addon_name)"

export ADDON_NAME