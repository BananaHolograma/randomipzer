#!/usr/bin/env bash

function rand_ipv4_byte() {
    echo -n $((RANDOM % 256))
}

function rand_ipv6_hex_block() {
    printf "%04x" $((RANDOM % 65536))
}

function random_ipv4() {
    printf "%s.%s.%s.%s" "$(rand_ipv4_byte)" "$(rand_ipv4_byte)" "$(rand_ipv4_byte)" "$(rand_ipv4_byte)"
}

function random_ipv6() {
    printf "%s:%s:%s:%s:%s:%s:%s:%s" \
    "$(rand_ipv6_hex_block)" "$(rand_ipv6_hex_block)" "$(rand_ipv6_hex_block)" "$(rand_ipv6_hex_block)" \
    "$(rand_ipv6_hex_block)" "$(rand_ipv6_hex_block)" "$(rand_ipv6_hex_block)" "$(rand_ipv6_hex_block)"
}

function randomize_ipv4_set() {
    declare -i times=$1
    local delimiter=${2:-','}
    local ip_addresses=''

    for index in $(seq 0 $times); do 
        ip_addresses+="$(random_ipv4)"
        [[ $index -lt $times ]] && ip_addresses+="$delimiter"
    done 

    echo -e "$ip_addresses"
}

function randomize_ipv6_set() {
    declare -i times=$1
    local delimiter=${2:-','}
    local ip_addresses=''

    for index in $(seq 0 $times); do 
        ip_addresses+="$(random_ipv6)"
        [[ $index -lt $times ]] && ip_addresses+="$delimiter"
    done 

    echo -e "$ip_addresses"
}
