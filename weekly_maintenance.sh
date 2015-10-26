#!/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
NC="\033[0m"

for D in */; do
    D=${D%*/}
    printf "Processing Repo: ${BLUE}$D${NC} \n"
    echo "Fetching from upstream..."
    cd $D
    git fetch -q upstream
    if [ $? == 0 ]; then
        printf "Status Fetching: ${GREEN}Berhasil${NC} \n"
        echo "Rebasing..."
        git rebase upstream/8.0
        if [ $? == 0 ]; then
            printf "Status Rebasing: ${GREEN}Berhasil${NC} \n"
            echo "Pushing to origin..."
            git push origin 8.0:8.0
            if [ $? == 0 ]; then
                printf "Status Push: ${GREEN}Berhasil${NC} \n"
            else
                printf "Status Push: ${RED}Gagal${NC}. Exit code: ${RED}$?${NC} \n"
            fi
        else
            printf "Status Rebasing: ${RED}Gagal${NC}. Exit code: ${RED}$?${NC} \n"
        fi
    else
        printf "Status Fetching: ${RED}Gagal${NC}. Exit code: ${RED}$?${NC} \n"
    fi
    echo
    echo
    cd ..
done
# cd $REPO
# git fetch upstream && git rebase upstream/8.0 && git push origin 8.0:8.0
