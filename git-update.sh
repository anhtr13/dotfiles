#!/bin/bash

count="$(git rev-list --count HEAD)"
git add -A
git commit -m "Update #$count"
git push origin main
