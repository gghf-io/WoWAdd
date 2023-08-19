#!/usr/bin/zsh

# COMMAND : wowadd

CONFIG="setup.conf"
PATH_CONFIG="$HOME/.scripts/wowadd/$CONFIG"
sed 's/ = /=/g' $CONFIG $PATH_CONFIG
. "$PATH_CONFIG"

REGISTRY="registry.conf"
PATH_REGISTRY="$HOME/.scripts/wowadd/$REGISTRY"
sed 's/ = /=/g' $REGISTRY $PATH_REGISTRY
. "$PATH_REGISTRY"

echo "$name"

local addon_dir="$(pwd)"
local addon_dir_parts=(${(@s:/:)dir})
local addon_dir_parts_len=${#parts[@]}

ADDON_NAME=$addon_dir_parts[$addon_dir_parts_len]

echo $addon_name

local path_wow_addon=
local path_dev_addon=

function copy_all() {
    cp -rf "$path_dev_addon/$ADDON_NAME" "$path_wow_addon/$ADDON_NAME"
}
function copy_one() {
    cp -rf "$path_dev_addon/$ADDON_NAME/$1" "$path_wow_addon/$ADDON_NAME/$1"
}
function copy_mtone() {
    i=1
    for file in "$@" 
    do
        echo $file[($i+1)]
        # copy_one $file[($i+1)]
        i=$((i + 1));
    done
    exit 0
}

function copy_help() {
    echo "Usage: wowadd [OPTION]...[FILEPATH | FILEPATH...]"
    echo "OPTION:"
    echo "      --all       Install files and directories in the addon folder"
    echo "      --one       Install one file or directorie in the addon folder"
    echo "      --mtone     Install many files and directories in the addon folder"
    exit 0
}

# $0

echo -e "\e[1;31m$1\e[0m copy to $path_wow_addon"
case $r in
    --all) copy_all ; break;;
    --one) copy_one $item; break;;
    --mtone) copy_mtone ; break;;
    --help) copy_help ; break;;
    *) copy_help ; break;
esac


exit 0