#!/bin/bash

wofi --show drun --normal-window &
WOFI_PID=$!
sleep 0.2

while [ "$(hyprctl activewindow -j | jq -r '.class')" == "wofi" ]; do
  sleep 0.1
done

kill $WOFI_PID
