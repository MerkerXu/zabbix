#!/bin/bash

stat() {
    /usr/sbin/ss -ant | awk 'NR>1 {++s[$1]} END{for(k in s) print k,s[k]}'
}

main() {
    case $1 in
        listen)
            stat | grep 'LISTEN' | awk '{print $2}'
            ;;
        syn_sent)
            stat | grep 'SYN-SENT' | awk '{print $2}'
            ;;
        syn_recv)
            stat | grep 'SYN-RECV' | awk '{print $2}'
            ;;
        established)
            stat | grep 'ESTAB' | awk '{print $2}'
            ;;
        fin_wait1)
            stat | grep 'FIN-WAIT-1' | awk '{print $2}'
            ;;
        close_wait)
            stat | grep 'CLOSE-WAIT' | awk '{print $2}'
            ;;
        closing)
            stat | grep 'CLOSING' | awk '{print $2}'
            ;;
        fin_wait2)
            stat | grep 'FIN-WAIT-2' | awk '{print $2}'
            ;;
        last_ack)
            stat | grep 'LAST-ACK' | awk '{print $2}'
            ;;
        time_wait)
            stat | grep 'TIME-WAIT' | awk '{print $2}'
            ;;
        *)
            echo "unknown: $0 $1"
            ;;
    esac
}

RET=$(main $1)

if [[ $RET ]]; then
    echo $RET
else
    echo 0
fi
