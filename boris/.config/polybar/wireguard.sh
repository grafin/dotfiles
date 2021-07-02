#!/usr/bin/env bash
CONNECTION=wg0
AVG_TIME=1

function calc() {
    /usr/bin/env awk "BEGIN { print $1 }"
}

function human() {
    awk -v var="$1" '
        function human(x) {
            s=" KB/s MB/s GB/s TB/s EB/s PB/s YB/s ZB/s"
            while (x>=1000 && length(s)>1) {
                x/=1024;
                s=substr(s, 6)
            }
            s=substr(s,1,5)
            printf("%d%s\n", x, s)
        }
        BEGIN { human(var) }
    '
}

function connection_status() {
    if [ -d "/sys/class/net/${CONNECTION}" ]; then
        echo "1"
    else
        echo "0"
    fi
}

function connection_rx() {
    echo $(cat "/sys/class/net/${CONNECTION}/statistics/rx_bytes" 2>/dev/null)
}

function connection_tx() {
    echo $(cat "/sys/class/net/${CONNECTION}/statistics/tx_bytes" 2>/dev/null)
}

RX_BYTES=0
TX_BYTES=0
while true; do
    if [ $(connection_status) -eq 1 ]; then
        PREV_RX_BYTES="${RX_BYTES}"
        PREV_TX_BYTES="${TX_BYTES}"
        RX_BYTES=$(connection_rx)
        TX_BYTES=$(connection_tx)
        DOWN_KB=$(calc "(${RX_BYTES} - ${PREV_RX_BYTES}) / 1024 / ${AVG_TIME}")
        UP_KB=$(calc "(${TX_BYTES} - ${PREV_TX_BYTES}) / 1024 / ${AVG_TIME}")
        DOWN_RATE=$(human "${DOWN_KB}")
        UP_RATE=$(human "${UP_KB}")
        echo "%{T4} %{T1}${DOWN_RATE}%{T4} %{T1}${UP_RATE}"
    else
        echo "%{F#f00}%{T4}"
    fi
    sleep "${AVG_TIME}"
done
