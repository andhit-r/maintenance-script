#!/bin/bash

# *******************************************************
# * Script: weekly_maintenance.sh                       *
# * Author: Andhitia Rama (andhitia.r@gmail.com         *
# * Version: 0.1                                        *
# * Date Created: 25/10/2015 UTC+7                      *
# * Function: (1) Fetch from upstream,                  *
# *           (2) Rebase                                *
# *           (3) Push to origin                        *
# *******************************************************

RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
NC="\033[0m"

# CLEAR SCREEN
clear

# LOOP THROUGH REPO
for repo in */; do
    repo=${repo%*/}
    printf "Processing Repo: ${BLUE}$repo${NC} \n"
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
