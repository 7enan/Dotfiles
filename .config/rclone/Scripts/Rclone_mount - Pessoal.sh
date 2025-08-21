#!/bin/bash

# --- CONFIGURAÇÕES ---
REMOTE_NAME="Pessoal:"
MOUNT_POINT="/home/renan/GDrives/Pessoal/"
LOG_FILE="/home/renan/.local/share/rclone/rclone-pessoal.log"

sleep=10

# 2. Verifica se o ponto de montagem já está em uso e desmonta se necessário
# Isso evita erros se o script for executado duas vezes ou se não foi desmontado corretamente.
if mountpoint -q "$MOUNT_POINT"; then
    echo "Ponto de montagem $MOUNT_POINT já está ativo. Desmontando antes de montar novamente." >> "$LOG_FILE"
    fusermount -u "$MOUNT_POINT"
    sleep 2 # Pequena pausa para garantir a desmontagem
fi

# 3. Garante que a pasta de montagem e a pasta de log existam
mkdir -p "$MOUNT_POINT"
mkdir -p "$(dirname "$LOG_FILE")"

# 4. Executa o comando de montagem do Rclone
# Usando as flags de otimização que discutimos
/usr/bin/rclone mount "$REMOTE_NAME" "$MOUNT_POINT" \
    --vfs-cache-mode full \
    --dir-cache-time 1000h \
    --poll-interval 1m \
    --log-level INFO \
    --log-file "$LOG_FILE" \
    --daemon

# A flag --daemon faz o processo rodar em segundo plano,
# então o script pode terminar e a montagem continuará ativa.

exit
