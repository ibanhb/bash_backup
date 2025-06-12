# Script de Actualización Mensual para Laboratorio (Fedora)

Este repositorio contiene un **script en Bash** diseñado para automatizar la **actualización mensual de paquetes** en sistemas **Fedora**, específicamente configurados para uso en un entorno de laboratorio. El script se asegura de:

- Verificar e instalar repositorios de terceros necesarios.
- Actualizar todo el sistema.
- Instalar o actualizar paquetes esenciales utilizados en el laboratorio.
- Ser ejecutado automáticamente una vez al mes mediante `cron`.

---

## 🧰 Paquetes Incluidos

El script se encarga de revisar, instalar o actualizar los siguientes paquetes:

| Paquete              | Descripción                             |
|---------------------|-----------------------------------------|
| `mate-desktop-environment` | Entorno de escritorio MATE       |
| `openssh-server`     | Servidor SSH                           |
| `emacs`             | Editor de texto GNU Emacs               |
| `vlc`               | Reproductor multimedia                  |
| `texlive-scheme-full` | Suite completa de herramientas LaTeX |
| `kile`              | Editor LaTeX                            |
| `texstudio`         | Editor LaTeX avanzado                   |
| `qgis`              | Sistema de Información Geográfica       |
| `gcc-gfortran`      | Compilador Fortran                      |
| `unrar`             | Herramienta para descomprimir archivos RAR |
| `p7zip`             | Compresor 7-Zip                         |
| `p7zip-plugins`     | Plugins adicionales para 7-Zip          |
| `gnuplot`           | Herramienta para graficación científica |
| `geogebra`          | Software matemático interactivo         |
| `firefox`           | Navegador web                           |
| `google-chrome-stable` | Navegador Google Chrome              |
| `libreoffice`       | Suite ofimática libre                   |
| `okular`            | Visor universal de documentos           |
| `pspp`              | Alternativa a SPSS para análisis estadístico |

> Nota: Algunos paquetes re
> Nota: Algunos paquetes requieren repositorios adicionales como **RPM Fusion** y **Google Chrome**. El script verifica e instala dichos repos si no están presentes.

---

## 🛠️ Requisitos del Sistema

- Sistema operativo: **Fedora**
- Permisos: **root** (el script debe ejecutarse como superusuario)
- Dependencias mínimas: `dnf`, `wget` (instalado automáticamente si es necesario)

---

## 📦 Estructura del Script

El script realiza las siguientes acciones en orden:

1. **Verificación de repositorios externos:**
   - RPM Fusion (libre y no libre)
   - Repositorio oficial de Google Chrome
   - Repositorio de GeoGebra (si aplica)

2. **Limpieza y actualización de repositorios**
3. **Actualización completa del sistema**
4. **Instalación o actualización de los paquetes definidos**
5. **Notificación de reinicio requerido (opcional)**

---

## 📅 Programación Automática con Cron

Para ejecutar el script una vez al mes (por ejemplo, el día 1 a las 2:00 AM), sigue estos pasos:

### 1. Copia el script a `/usr/local/bin`

```bash
sudo cp actualizar_fedora.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/actualizar_fedora.sh