#!/bin/bash

# --- CONFIGURAÇÕES ---
REMOTE_NAME="Jogos:"
MOUNT_POINT="/home/renan/GDrives/Jogos/"
LOG_FILE="/home/renan/.local/share/rclone/rclone-jogos.log"

sleep=10

# 2. Verifica se o ponto de montagem já está em uso e desmonta se necessário
if mountpoint -q "$MOUNT_POINT"; then
    echo "Ponto de montagem $MOUNT_POINT já está ativo. Desmontando antes de montar novamente." >> "$LOG_FILE"
    fusermount -u "$MOUNT_POINT"
    sleep 2
fi

# 3. Garante que a pasta de montagem e a pasta de log existam
mkdir -p "$MOUNT_POINT"
mkdir -p "$(dirname "$LOG_FILE")"

# 4. Executa o comando de montagem do Rclone
/usr/bin/rclone mount "$REMOTE_NAME" "$MOUNT_POINT" \
    --vfs-cache-mode full \
    --dir-cache-time 1000h \
    --poll-interval 1m \
    --log-level INFO \
    --log-file "$LOG_FILE" \
    --daemon

exit
