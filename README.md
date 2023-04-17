`randomipzer` is a simple tool writted in bash with zero dependencies. Generate the amount selected of random valid ip addresses with the possibility to choose the ipv4 or ipv6 format

# Installation

```bash
wget https://raw.githubusercontent.com/s3r0s4pi3ns/randomipzer/main/randomipzer.sh

chmod +x ramdomipzer && cp ramdomipzer /usr/local/bin
```

# Usage

```bash
USAGE:
    randomipzer [OPTIONS]
    Delimiter '\n' is set by default
    ipv4 mode is selected by default

EXAMPLES:
    randomipzer --times 20
    randomipzer -t 100 -d ','
    ramdomipzer --times 50 --delimiter ' ' --mode ipv6

OPTIONS:
    -m  --mode      <ipv4,ipv6,both>     Choose the ip category to randomly generate the values
    -t  --times     <int>                (mandatory) Number of ip addresses to generate
    -d  --delimiter <value>              Delimiter to separate the ip addresses in the output
    -h  --help                           Print help information
```

## Examples

Generate a bunch of random ipv4 to spoof the origin on nmap scan

```bash
# -D <decoy1,decoy2[,ME],...>: Cloak a scan with decoys
nmap -p- --min-rate 5000 -sS 192.168.1.101 -D $(randomipzer -t 10 --delimiter ',') --data-length 78 -vvv

```
