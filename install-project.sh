#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: $0 <project-name>"
    curl -s https://api.github.com/repos/EDortta/yeapf2-tools/contents/distros | grep -o '"name": *"[^"]*"' | awk '{$1=$1};1' | sed 's/^"name": //' | tr -d '"' | grep -v README.md | while read file; do echo "    ${file%.zip}"; done
    exit 0
fi

jq=`which jq`
if [ -z "$jq" ]; then
    echo "jq not installed"
    exit 1
fi

c=`which composer`
if [ -z "$c" ]; then
    echo "composer not installed"
    exit 1
fi

if [ ! -d "www" ]; then
    curl -s -L https://github.com/EDortta/yeapf2-tools/raw/main/distros/$1.zip -o $1.zip
    mkdir -p www
    unzip -q -d www $1.zip
    mkdir -p www/web/.config -p
    namespace=$(cat /dev/urandom | tr -dc 'a-f0-9' | head -c8; echo -n '-'; cat /dev/urandom | tr -dc 'a-f0-9' | head -c4; echo -n '-'; cat /dev/urandom | tr -dc 'a-f0-9' | head -c4; echo -n '-'; cat /dev/urandom | tr -dc 'a-f0-9' | head -c4; echo -n '-'; cat /dev/urandom | tr -dc 'a-f0-9' | head -c12)
    jwtKey=$(cat /dev/urandom | tr -dc 'a-f0-9' | head -c32)
    config=$(jq '.namespace = "'"$namespace"'" | .jwtKey = "'"$jwtKey"'"' www/web/.config-sample/randomness.json)
    echo "$config" > www/web/.config/randomness.json
    echo ""
    echo "randomness.json created"

    cp www/web/.config-sample/connection.json www/web/.config/connection.json
    echo "connection.json copied"

    cp www/web/.config-sample/mode.json www/web/.config/mode.json
    echo "mode.json copied"

    echo "You need to copy i18n from web/.config-sample/i18n to web/.config/i18n"
    echo "with your own values."

    echo "Project created"

    pushd www && composer  install && popd
    pushd www/web && ./build.sh && popd

    rm -f $1.zip
fi
