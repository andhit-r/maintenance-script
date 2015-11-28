#!/bin/bash


RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
NC="\033[0m"


fetch_origin()
{
    echo "Fetching from origin..."
    if git fetch -q origin; then
        printf "Status Fetching: ${GREEN}Berhasil${NC} \n"
        rebase_origin
    else
        printf "Status Fetching: ${RED}Gagal${NC}. Exit code: ${RED}$?${NC} \n"
    fi
}


rebase_origin()
{
    echo "Rebasing..."
    if git rebase origin/8.0; then
        printf "Status Rebasing: ${GREEN}Berhasil${NC} \n"
    else
        printf "Status Rebasing: ${RED}Gagal${NC}. Exit code: ${RED}$?${NC} \n"
    fi
}

for repo in */; do
    repo=${repo%*/}
    cd $repo
    printf "Processing Repo: ${BLUE}$repo${NC} \n"
    fetch_origin
    echo
    echo
    cd ..
done
