#!/bin/bash

CONFIG_FILE="~/Dotfiles/rofi/config.ras"

# Lança o Rofi em modo drun e captura seu PID
rofi -show drun -config $CONFIG_FILE &
ROFI_PID=$!

# Adiciona um pequeno atraso para dar tempo ao Rofi de se tornar a janela ativa
sleep 0.2

# Espera até que a janela do Rofi não seja mais a janela ativa.
# A classe da janela do Rofi geralmente é "Rofi".
# Use `hyprctl activewindow -j | jq .` para confirmar a classe no seu sistema.
while [ "$(hyprctl activewindow -j | jq -r '.class')" == "Rofi" ]; do
  sleep 0.1
done

# Assim que o Rofi perder o foco, mata o processo se ele ainda estiver rodando.
kill $ROFI_PID >/dev/null 2>&1
