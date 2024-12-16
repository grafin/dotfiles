#!/usr/bin/env python3

import scapy.all as scapy
import argparse

def knock(host: str, key: tuple[int], mode: str = 'open'):
    packets: list[scapy.Packet] = []

    ip = scapy.IP(dst=host)

    if mode == 'open':
        ports = key
    elif mode == 'close':
        ports = reversed(key)
    else:
        raise ValueError('Invalid mode')

    for port in ports:
        SYN = scapy.TCP(dport=port, flags='S')
        packet = ip / SYN
        packets.append(packet)

    scapy.send(packets, inter=0.5, realtime=True)

def main():
    parser = argparse.ArgumentParser(description='Port knocker')
    parser.add_argument('--mode', type=str, default='open', help='Knock mode (open/close)')
    parser.add_argument('host', type=str, help='Host to knock on')
    parser.add_argument('key', type=int, nargs='+', help='Knock key')
    args = parser.parse_args()

    knock(args.host, args.key, args.mode)

if __name__ == '__main__':
    main()
