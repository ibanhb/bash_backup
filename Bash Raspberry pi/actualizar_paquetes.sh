#!/bin/bash

# Ruta del log (puede ser opcional)
LOGFILE="/home/pi/logs/actualizacion_paquetes.log"

# Crear directorio de logs si no existe
mkdir -p "$(dirname "$LOGFILE")"

# Iniciar log
echo "[$(date)] Iniciando actualización de paquetes" >> "$LOGFILE"

# Actualizar lista de paquetes
echo "[$(date)] Ejecutando apt update..." >> "$LOGFILE"
sudo apt update >> "$LOGFILE" 2>&1

# Actualizar paquetes instalados
echo "[$(date)] Ejecutando apt upgrade..." >> "$LOGFILE"
sudo apt upgrade -y >> "$LOGFILE" 2>&1

# Limpiar sistema (opcional)
echo "[$(date)] Ejecutando apt autoremove y autoclean..." >> "$LOGFILE"
sudo apt autoremove -y >> "$LOGFILE" 2>&1
sudo apt autoclean >> "$LOGFILE" 2>&1

echo "[$(date)] Actualización completada." >> "$LOGFILE"

#Yo utilizo Rpi-Monitor para poder ver la actividad y la actualizo de la siguiente manera
echo "[$(date)] Actualizacion de rpi-monitor.">> "$LOGFILE"
sudo  /etc/init.d/rpimonitor update
