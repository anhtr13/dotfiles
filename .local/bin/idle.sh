#!/usr/bin/env bash

swayidle -w \
    timeout 600 'brightnessctl -s set 10' \
    resume 'brightnessctl -r' \
    timeout 900 'swaylock -f' \
    resume 'brightnessctl -r'
