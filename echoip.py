#!/usr/bin/env python

# ECHOIP - listen on TCP port given as argument and answer client's IP to client
# requests. It listens on all IPv6 interfaces and IPv4 requests and treaten in
# IPv6 dual stack. Usage:
#   echoip.py PORT

from socket import *
from sys import argv

def listen(address, port):
    s = socket(AF_INET6, SOCK_STREAM)
    s.setsockopt(IPPROTO_IPV6, IPV6_V6ONLY, 0)
    s.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
    s.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
    s.bind((address, port))
    s.listen(8)

    while True:
        connect, client = s.accept()
        ip = '%s\n' % client[0].replace("::ffff:", "")
        connect.send(ip.encode())
        connect.shutdown(2)

    s.close()

if __name__ == "__main__":
    listen('', int(argv[1]))

