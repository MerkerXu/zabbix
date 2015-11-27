#!/bin/bash

stat() {
    cat /proc/diskstats | awk -v pat="^$1$" -v field=$2 '$3 ~ pat {print $field}'
}

main() {
    case $2 in
        read)
            stat $1 4
            ;;
        mread)
            stat $1 5
            ;;
        sread)
            stat $1 6
            ;;
        read_ms)
            stat $1 7
            ;;
        write)
            stat $1 8
            ;;
        mwrite)
            stat $1 9
            ;;
        swrite)
            stat $1 10
            ;;
        write_ms)
            stat $1 11
            ;;
        active)
            stat $1 12
            ;;
        ms)
            stat $1 13
            ;;
        ms_total)
            stat $1 14
            ;;
        *)
            echo "unknown: $0 $1"
    esac
}

RET=$(main $1 $2)

if [[ $RET ]]; then
    echo $RET
else
    echo 0
fi
