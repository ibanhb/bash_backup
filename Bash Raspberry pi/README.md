# Script de Actualización Automática para Raspberry Pi

Este repositorio contiene un **script Bash** diseñado para automatizar la **actualización semanal de paquetes** en una **Raspberry Pi** (con sistema operativo basado en Debian, como Raspberry Pi OS).

## 🎯 Objetivo

El propósito del script es mantener tu Raspberry Pi actualizada automáticamente, asegurando que tengas las últimas correcciones de seguridad y mejoras en tus paquetes instalados.

## 🛠️ Funcionalidades

- Ejecuta `apt update` para actualizar la lista de paquetes disponibles.
- Realiza `apt upgrade -y` para instalar las últimas versiones de los paquetes.
- Limpia el sistema con `apt autoremove` y `apt autoclean`.
- Registra todo en un archivo de log para auditoría futura.
- Es compatible con ejecución automática mediante `cron`.

## 🧪 Requisitos

- Raspberry Pi con sistema operativo basado en Debian (ej: Raspberry Pi OS).
- Acceso a terminal o conexión SSH.
- Permiso de superusuario (`sudo`).
- `cron` instalado (viene por defecto en la mayoría de las imágenes de RPi OS).

## 📁 Estructura del Repositorio
├── actualizar_paquetes.sh # El script principal
├── logs/ # Carpeta donde se guardan los registros de ejecución
└── README.md # Este archivo

## ⏰ Programación con Cron

Para ejecutar este script **una vez por semana a las 4:00 AM**, agrega esta línea a tu crontab (`crontab -e`):

```cron
0 4 * * 0 /home/pi/actualizar_paquetes.sh