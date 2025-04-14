#!/bin/bash

# Verifica si VBoxManage está instalado
if ! command -v VBoxManage &> /dev/null; then
    echo "VBoxManage no está instalado. Por favor instálalo primero."
    exit 1
fi

# Validación de argumentos
if [ "$#" -ne 7 ]; then
    echo "Uso: $0 <Nombre_VM> <Tipo_SO> <CPUs> <RAM_GB> <VRAM_MB> <Tamaño_Disco_GB> <Nombre_Controladores>"
    echo "Ejemplo: $0 LinuxVM 'Linux_64' 2 4 128 100 Controlador"
    exit 1
fi

# Argumentos
NOMBRE_VM=$1
TIPO_SO=$2
CPUS=$3
RAM=$(($4 * 1024))          # Convertir a MB
VRAM=$5
DISCO_GB=$6
CONTROLADOR=$7

# Ruta del disco virtual
DISCO_PATH="$HOME/VirtualBox VMs/$NOMBRE_VM/$NOMBRE_VM.vdi"

# Crear la VM
VBoxManage createvm --name "$NOMBRE_VM" --ostype "$TIPO_SO" --register

# Configurar CPU, RAM y VRAM
VBoxManage modifyvm "$NOMBRE_VM" --cpus $CPUS --memory $RAM --vram $VRAM

# Crear el disco duro virtual
VBoxManage createmedium disk --filename "$DISCO_PATH" --size $(($DISCO_GB * 1024)) --format VDI

# Crear y asociar el controlador SATA
VBoxManage storagectl "$NOMBRE_VM" --name "$CONTROLADOR-SATA" --add sata --controller IntelAhci
VBoxManage storageattach "$NOMBRE_VM" --storagectl "$CONTROLADOR-SATA" --port 0 --device 0 --type hdd --medium "$DISCO_PATH"

# Crear y asociar el controlador IDE para CD/DVD
VBoxManage storagectl "$NOMBRE_VM" --name "$CONTROLADOR-IDE" --add ide
VBoxManage storageattach "$NOMBRE_VM" --storagectl "$CONTROLADOR-IDE" --port 0 --device 0 --type dvddrive --medium emptydrive

# Mostrar configuración
echo "---------------------------------------------"
echo "Máquina Virtual '$NOMBRE_VM' creada exitosamente:"
VBoxManage showvminfo "$NOMBRE_VM"
echo "---------------------------------------------"
