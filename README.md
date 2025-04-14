# Challenge 1: Automatización de Máquina Virtual con VBoxManage

Este repositorio contiene el script `vm_auto_setup.sh`, que automatiza la creación y configuración de una Máquina Virtual utilizando la herramienta `VBoxManage` de VirtualBox.

## 📌 Descripción

El script automatiza:

- Creación de una nueva Máquina Virtual con nombre y tipo de SO.
- Configuración de CPU, RAM y VRAM.
- Creación de un disco duro virtual (VDI).
- Creación y asignación de controladores SATA (para HDD) e IDE (para CD/DVD).
- Impresión del resumen de configuración.

## ⚙️ Uso

```bash
./vm_auto_setup.sh <Nombre_VM> <Tipo_SO> <CPUs> <RAM_GB> <VRAM_MB> <Tamaño_Disco_GB> <Nombre_Controladores>
