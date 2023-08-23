#!/usr/bin/zsh
# Name : wowadd
# VERSION : 1.0.0

echo "\e[1;31m  __      __               _____       .___  .___ \e[0m"
echo "\e[1;31m /  \    /  \______  _  __/  _  \    __| _/__| _/ \e[0m"
echo "\e[1;31m \   \/\/   /  _ \ \/ \/ /  /_\  \  / __ |/ __ |  \e[0m"
echo "\e[1;31m  \        (  <_> )     /    |    \/ /_/ / /_/ |  \e[0m"
echo "\e[1;31m   \__/\  / \____/ \/\_/\____|__  /\____ \____ |  \e[0m"
echo "\e[1;31m        \/                      \/      \/    \/  \e[0m"

source $(dirname "$0")/wowadd_utils.zsh

CONFIG="$(dirname "$0")/setup.conf"

while IFS='=' read -r key value; do
    if [[ $key && $value ]]; then
        declare "$key=$value"
    fi
done < $CONFIG

path_prd="${path_wow_prd_addon:1:-1}"
path_dev="${path_workspace:1:-1}"

function wowadd_all() {
    cp -Rf $path_dev/$ADDON_NAME $path_prd
    echo -e "[ \e[1;31m$ADDON_NAME\e[0m ] copied !";
    exit 0
}

function wowadd_one() {

    cp -Rf $path_dev/$ADDON_NAME/$2 $path_prd/$ADDON_NAME/$2

    echo -e "$(date) [ \e[1;31m$2\e[0m ] copied !";

    if [[ $1 == $argument_key_one ]]; then
        exit 0
    fi
    return;
}

function wowadd_mt() {
    echo -e "[wowadd_mt] $@";

    local array=("$@");
    local array_len=${#array[@]};

    for filepath in ${array[@]}
    do
        wowadd_one $argument_key_mt $filepath;
        if [[ $array_len == 0 ]]; then
            exit 0;
        else
            array_len=$((array_len + 1));
        fi
    done
}

function wowadd_add_registry() {
    local prefix=$"$1"
    sed -i "s/\($value * *\).*/\1$ADDON_NAME/" $CONFIG
    exit 0
}

echo -e "[ \e[1;31m$plugin_name\e[0m ] va copier l'addon [ \e[1;31m$ADDON_NAME\e[0m ] dans le dossier \e[1;31m$path_prd\e[0m";

local array_argument=("$@")
local checker=$@[1]
local array_path=(${array_argument[@]:1})

case $checker in
    $argument_key_all) wowadd_all;;
    $argument_key_one) wowadd_one $checker $@[2];;
    $argument_key_mt) wowadd_mt "${array_path[@]}";;
    $argument_key_help) wowadd_help;;
    *) wowadd_help;;
esac

exit 0
