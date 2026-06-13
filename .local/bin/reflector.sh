#!/usr/bin/env bash

sudo reflector -c VN,JP,SG -a 24 --sort rate -n 6 --save /etc/pacman.d/mirrorlist
