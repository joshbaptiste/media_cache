#!/usr/bin/env bash

script=$(basename $0)
declare -r MAX_CACHE=80000000 #80GB in KB 
declare -r MIN_SPACE=2000000  #2GB space in KB
declare -r CACHE_DIR=/mnt/superfree/media/cache
declare -r TV_SERIES=/mnt/superfree/media/tv_series
declare -r FILMS=/mnt/superfree/media/films

function check_running(){
    pgrep -f $script &&  echo "im already running" && exit 2
}

function check_space() {
    local current_space=$(df -kP "$dir")
}

function create_links(){
    while read line
    do
        if [[ ! -e "$CACHE_DIR/$line" ]] 
        then
            ln -s "$line" "$CACHE_DIR/$line" 
        fi
    done < <(find $TV_SERIES $FILMS)
}

funct

