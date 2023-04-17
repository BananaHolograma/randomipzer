#!/usr/bin/env bash

function rand_byte() {
    echo $((RANDOM % 256))
}

function random_ipv4() {
    echo "$(rand_byte).$(rand_byte).$(rand_byte).$(rand_byte)"
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
