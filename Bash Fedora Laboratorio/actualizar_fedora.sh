#!/bin/bash

# Nombre del script: actualizar_fedora.sh
# Descripción: Actualiza sistema Fedora y paquetes específicos una vez al mes
# Autor: ibanhb
# Fecha: 2025-04-05

LOGFILE="/var/log/actualizar_fedora.log"
EMAIL="ihbarrera@protonmail.com"  # Mi correo empresarial

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') | $1" | tee -a "$LOGFILE"
}

log "🚀 Iniciando actualización mensual del sistema Fedora con repos externos..."

# Verificar si se ejecuta como root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Este script debe ejecutarse como root."
  exit 1
fi

# --- VERIFICAR E INSTALAR REPOSITORIOS EXTERNOS ---

log "🔍 Verificando repositorios adicionales..."

# RPM Fusion - Libre
if ! dnf repolist | grep -q rpmfusion-free; then
    log "📦 Instalando repositorio RPM Fusion (Libre)..."
    dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm  -E %fedora).noarch.rpm
fi

# RPM Fusion - No Libre
if ! dnf repolist | grep -q rpmfusion-nonfree; then
    log "📦 Instalando repositorio RPM Fusion (No Libre)..."
    dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm  -E %fedora).noarch.rpm
fi

# Google Chrome
CHROME_REPO="/etc/yum.repos.d/google-chrome.repo"
if [ ! -f "$CHROME_REPO" ]; then
    log "📦 Instalando repositorio de Google Chrome..."
    dnf install -y wget
    wget https://dl.google.com/linux/direct/google-chrome.repo  -O $CHROME_REPO
    rpm --import https://dl.google.com/linux/linux_signing_key.pub 
fi

# GeoGebra (si existe un repo oficial actualizado)
GEOGEBRA_REPO="/etc/yum.repos.d/geogebra.repo"
if [ ! -f "$GEOGEBRA_REPO" ]; then
    log "📦 Añadiendo repositorio GeoGebra (manual)... Nota: puede requerir ajuste manual si URL cambia."
    cat <<EOL > $GEOGEBRA_REPO
[GeoGebra]
name=GeoGebra
baseurl=https://download.geogebra.net/linux/fedora/x86_64/ 
enabled=1
gpgcheck=1
gpgkey=https://www.geogebra.net/en/download/gpg_keys/geogebra_release.asc 
EOL
    rpm --import https://www.geogebra.net/en/download/gpg_keys/geogebra_release.asc 
fi

# --- ACTUALIZACIÓN GENERAL DEL SISTEMA ---

log "🧹 Limpiando caché de DNF..."
dnf clean all --quiet

log "🔄 Sincronizando repositorios..."
dnf makecache --quiet

log "📦 Actualizando todos los paquetes del sistema..."
dnf upgrade -y

# --- INSTALACIÓN O ACTUALIZACIÓN DE PAQUETES ESPECÍFICOS ---

PAQUETES=(
    mate-desktop-environment         # Escritorio MATE
    openssh-server                   # Servidor OpenSSH
    emacs                            # Editor Emacs
    vlc                              # Reproductor VLC
    texlive-scheme-full              # TeX Live Full
    kile                             # Editor LaTeX Kile
    texstudio                        # Editor LaTeX TeXStudio
    qgis                             # Sistema de Información Geográfica
    gcc-gfortran                     # GFortran
    unrar                            # Soporte RAR
    p7zip                            # Compresor 7-Zip
    p7zip-plugins                    # Plugins adicionales para 7-Zip
    gnuplot                          # Graficación científica
    geogebra                         # Software matemático interactivo
    firefox                          # Navegador web
    google-chrome-stable             # Google Chrome
    libreoffice                      # Suite ofimática
    okular                           # Visor universal de documentos
    pspp                             # Análisis estadístico
)

for paquete in "${PAQUETES[@]}"; do
    if dnf list installed "$paquete" &>/dev/null; then
        log "🔁 Actualizando paquete instalado: $paquete"
        dnf upgrade -y "$paquete"
    else
        log "📥 Instalando paquete faltante: $paquete"
        dnf install -y "$paquete"
    fi
done


# --- COMPROBAR SI SE NECESITA REINICIAR ---

if [ -f /var/run/reboot-required ]; then
    log "⚠️ Se requiere reiniciar el sistema para aplicar cambios."
    echo "ℹ️ Reinicia manualmente cuando sea conveniente."
fi

log "✅ Finalizada la actualización completa."

exit 0