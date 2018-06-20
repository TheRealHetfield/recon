#!/bin/bash
#
# This script launchs a series of nmap port scans used to gather information at the onset of a penetration testing engagement.
# Input validation is not implemented. Use your brain, or write your own.
#
# . recon.sh <ip> <name>
#
RED=$(echo -ne '\033[00;31m')
GREEN=$(echo -ne '\033[00;32m')
YELLOW=$(echo -ne '\033[01;33m')
BLUE=$(echo -ne '\033[00;34m')
NC=$(echo -ne '\033[0m')
BOXES="/media/sf_htb/boxes"

if [ "$#" -ne 2 ]
then
	echo "Usage: . recon.sh <ip> <name>"
fi

echo "${GREEN}[+] Starting Nmap -sT -sV -sC Scan.${NC}"
nmap -v --stats-every 15 -Pn -n -sT -sV -sC --open --privileged -oA ${BOXES}/$2/scans/nmap_$2_tcp_1000 $1
echo "${GREEN}[+] Finished Nmap -sT -sV -sC Scan.${NC}"
echo "${GREEN}[+] Displaying nmap_$2_tcp_1000.nmap.${NC}"
cat ${BOXES}/$2/scans/nmap_$2_tcp_1000.nmap

echo "${GREEN}[+] Starting Nmap -sT -p- -sV -sC Scan.${NC}"
nmap -v --stats-every 15 -Pn -n -sT -p- -sV -sC --open --privileged -oA ${BOXES}/$2/scans/nmap_$2_tcp_all $1
echo "${GREEN}[+] Finished Nmap -sT -p- -sV -sC Scan.${NC}"
echo "${GREEN}[+] Displaying ndiff nmap_$2_tcp_1000.xml nmap_$2_tcp_all.xml.${NC}"
ndiff ${BOXES}/$2/scans/nmap_$2_tcp_1000.xml ${BOXES}/$2/scans/nmap_$2_tcp_all.xml

echo "${GREEN}[+] Starting Nmap -sU -sV -sC Scan.${NC}"
nmap -v --stats-every 15 -Pn -n -sU --top-ports 100 -sV -sC --open --privileged -oA ${BOXES}/$2/scans/nmap_$2_udp_100 $1
echo "${GREEN}[+] Finished Nmap -sU -sV -sC Scan.${NC}"
echo "${GREEN}[+] Displaying nmap_$2_udp_100.nmap.${NC}"
cat ${BOXES}/$2/scans/nmap_$2_udp_100.nmap
