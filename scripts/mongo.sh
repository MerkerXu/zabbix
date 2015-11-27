#!/bin/bash

stat() {
    /usr/local/mongodb/bin/mongo octopus --quiet --eval "printjson($@)"
}

main() {
    case $2 in 
        serverStatus|stats)
            CMD="db.$2()"
            ;;
        isMaster)
            CMD="rs.$2()"
            ;;
    esac

    shift 2

    for elem in $@
    do
       CMD=$CMD.$elem 
    done
    stat $CMD
}

main $@
