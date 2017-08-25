#!/usr/bin/env bash

declare -r SCRIPT=$(basename $0)
declare -r MAX_CACHE=80000000 #80GB in KB 
declare -r MIN_SPACE=2000000  #2GB space in KB
declare -r CACHE_DIR=/mnt/superfree/media/cache
declare -r DIR_ROOT=/mnt/superfree/media
declare -r TV_SERIES=/mnt/superfree/media/tv_series
declare -r FILMS=/mnt/superfree/media/films

function check_running(){
    pgrep -f $script &&  echo "im already running" && exit 2
}

function check_space() {
    local current_space=$(df -k  --output=avail "$dir" | awk 'NR==2')
    if [[ $current_space -lt $MIN_SPACE ]]
    then
        remove_local_files
        remove_local_dirs
        exit 3
    fi
}

function remove_local_dirs() {
    find $CACHE_DIR -type d  -mtime +30 -exec rmdir --ignore-fail-on-non-empty "{}" \;
}

function remove_local_files() {
    find $CACHE_DIR -type f  -mtime +30 -exec rm -f "{}" \;
}

function copy_tvcache_files(){
    while IFS= read -r -d '' line
    do
        if [[ ! -e "$CACHE_DIR/$line" ]]
        then
            find $TV_SERIES -maxdepth 1 -exec cp --no-clobber -as "tv_series/$line" "$CACHE_DIR/$line"
        fi
    done < <(find $TV_SERIES -print0 )
}


