#!/usr/bin/env bash

status=$(wg show 2>&1);
if [ -z  "$status" ]; then
    echo " OFF"
else
    echo " ON"
fi
