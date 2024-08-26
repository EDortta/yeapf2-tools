#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: $0 <project-name>"
    curl -s https://api.github.com/repos/EDortta/yeapf2-tools/contents/distros | grep -o '"name": *"[^"]*"' | awk '{$1=$1};1' | sed 's/^"name": //' | tr -d '"' | grep -v README.md | while read file; do echo "    ${file%.zip}"; done
    exit 0
fi

if [ ! -d "www" ]; then
    curl -s -L https://github.com/EDortta/yeapf2-tools/raw/main/distros/$1.zip -o $1.zip
    mkdir -p www
    unzip -q -d www $1.zip
    rm -f $1.zip
fi
