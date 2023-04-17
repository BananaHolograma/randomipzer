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
    local delimiter=${2:-'\n'}
    local ip_addresses=''

    for index in $(seq 0 $times); do 
        ip_addresses+="$(random_ipv4)"
        [[ $index -lt $times ]] && ip_addresses+="$delimiter"
    done 

    echo -e "$ip_addresses" | sort -u
}

function randomize_ipv6_set() {
    declare -i times=$1
    local delimiter=${2:-'\n'}
    local ip_addresses=''

    for index in $(seq 0 $times); do 
        ip_addresses+="$(random_ipv6)"
        [[ $index -lt $times ]] && ip_addresses+="$delimiter"
    done 

    echo -e "$ip_addresses" | sort -u
}

show_help() {
    cat <<'EOF'
USAGE:
    randomipzer [OPTIONS]
    Delimiter '\n' is set by default
    ipv4 mode is selected by default

EXAMPLES:
    randomipzer --times 20 
    randomipzer -t 100 -d '\n'
    ramdomipzer --times 50 --delimiter ' ' --mode ipv6

OPTIONS:
    -m  --mode   <ipv4,ipv6,both>     Choose the ip category to randomly generate the values
    -t, --times   <int>               (mandatory) Number of ip addresses to generate
    -d  --delimiter <value>           Delimiter to separate the ip addresses in the output
    -h  --help                        Print help information
EOF
}


declare -i TIMES
declare -i TIMES_FLAG=0
declare -g  MODE='ipv4'

to_lowercase() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

is_empty() {
    local value=$1 

    [[ -z $value ]]
}

set_mode() {
    declare -a available_modes=("ipv4" "ipv6" "both")
    declare -i valid_mode=0
    local selected_mode
    selected_mode=$(to_lowercase "$1")

    for mode in "${available_modes[@]}"; do
        if [ "$mode" = "$selected_mode" ]; then
            MODE=$mode
            valid_mode=1
            break
        fi
    done

    if [ $valid_mode -eq 0 ]; then
        echo -e "The selected mode $selected_mode is invalid, allowed values are: ${available_modes[*]}. The default mode $MODE will be used instead"
    fi
}


for arg in "$@"; do
  shift
  case "$arg" in
     '--mode')           set -- "$@" '-m'   ;;
     '--times')          set -- "$@" '-t'   ;;
     '--delimiter')      set -- "$@" '-d'   ;;
    '--help')            set -- "$@" '-h'   ;;
    *)                   set -- "$@" "$arg" ;;
  esac
done

while getopts ":t:m:d:h" arg; do
    case $arg in
        t) 
            TIMES="$OPTARG"
            TIMES_FLAG=1
            if is_empty $TIMES || [[ ! $TIMES -gt 0 ]] ; then 
                echo -e "-t/--times option for the amount of values to be generated is not valid"
                exit 2
            fi 
        ;;
        m) set_mode "$OPTARG";;
        d) DELIMITER=${OPTARG:-'\n'};;
        :)
             echo -e "The option -$OPTARG requires an argument"
             exit 1
        ;;
        h | *)
            show_help
            exit 0
        ;;
    esac

done
shift $(( OPTIND - 1))

if [[ $TIMES_FLAG -eq 0 ]]; then 
        echo -e 'This script requires a --times option value'
        exit 3
fi 

if [ "$MODE" = 'ipv4' ]; then
    randomize_ipv4_set $TIMES "$DELIMITER"
elif [ "$MODE" = 'ipv6' ]; then 
    randomize_ipv6_set $TIMES "$DELIMITER"
else 
    randomize_ipv4_set $TIMES "$DELIMITER"
    randomize_ipv6_set $TIMES "$DELIMITER"
fi