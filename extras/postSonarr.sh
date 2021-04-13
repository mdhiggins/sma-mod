#!/usr/bin/env bash

# env check
if [[ -z "${SMA_PATH}" ]]; then
    export SMA_PATH="/usr/local/sma"
fi

$SMA_PATH/venv/bin/python3 $SMA_PATH/postSonarr.py
