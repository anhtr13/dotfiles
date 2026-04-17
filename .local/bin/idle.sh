#!/usr/bin/env bash

swayidle -w \
    timeout 300 'brightnessctl -s set 10' \
    resume 'brightnessctl -r' \
    timeout 600 'swaylock -f' \
    resume 'brightnessctl -r' \
    timeout 900 'systemctl suspend'
