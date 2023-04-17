![ramdomipzer-thumbnail](/assets/stable_diffusion_computer_basement.jpg)

`randomipzer` is a simple tool writted in bash with zero dependencies. Generate the amount selected of random valid ip addresses with the possibility to choose the ipv4 or ipv6 format

# Installation

```bash
# Download the script
wget --output-document randomipzer https://raw.githubusercontent.com/s3r0s4pi3ns/randomipzer/main/randomipzer.sh
# or
curl -o randomipzer https://raw.githubusercontent.com/s3r0s4pi3ns/randomipzer/main/randomipzer.sh

# Make the binary available in your system
chmod +x ramdomipzer && cp ramdomipzer /usr/local/bin/randomipzer
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

# Examples

## Generate a bunch of random ipv4 to spoof the origin of your packets on nmap scan

```bash
# -D <decoy1,decoy2[,ME],...>: Cloak a scan with decoys
nmap -p- --min-rate 5000 -sS 192.168.1.101 -D $(randomipzer -t 10 --delimiter ' ') --data-length 78 -vvv
```

## Save generated values into a file

```bash
randomipzer --times 25 --mode ipv4 > ips.txt

# ips.txt
110.174.177.179
181.172.23.69
202.253.99.246
210.1.3.101
214.152.90.35
226.252.5.43
29.231.14.30
70.21.78.181
79.52.99.55
80.171.163.35
94.178.83.244
//...

```

## Generated values for both ip formats

Take into account that the times value is used by both, so 20 ipv4 and 20 ipv6

```bash
randomipzer -t 20 --mode both


104.100.145.208
109.62.206.205
14.66.44.57
169.107.225.17
181.18.103.234
60.229.83.122
057c:2f41:25cb:360c:4b34:2f44:75bb:423f
2316:6854:077e:126a:0fb2:10c0:4df4:49eb
3cf2:2b91:4b9e:0b58:4683:0d86:1c61:571e
403d:06b7:35e0:6143:3752:36ad:6bd5:4c1f
56ba:2eca:7cfb:7833:1207:2330:4c85:5e52
6f52:5586:474a:2c71:79e1:42f7:0a3d:14a2
```

## Generate different amount of values for each ip format on same file

```bash
randomipzer -t 25 -m ipv4 > ips.txt
randomipzer -t 5 -m ipv6 >> ips.txt
```
