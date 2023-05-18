#!/usr/bin/env bash

dir_count=0
file_count=0

traverse() {
  dir_count=$(expr $dir_count + 1)
  local directory=$1
  local prefix=$2

  local children=($(ls $directory))
  local child_count=${#children[@]}

  for i in "${!children[@]}"; do 
    local child="${children[$i]}"
    local child_prfx="│   "
    local pointer="├── "

    if [ $i -eq $(expr ${#children[@]} - 1) ]; then
      pointer="└── "
      child_prfx="    "
    fi

    echo "${prefix}${pointer}$child"
    [ -d "$directory/$child" ] &&
      traverse "$directory/$child" "${prefix}$child_prfx" ||
      file_count=$(expr $file_count + 1)
  done
}

root="."
[ "$#" -ne 0 ] && root="$1"
echo $root

traverse $root ""
echo
echo "$(expr $dir_count - 1) directories, $file_count files"
