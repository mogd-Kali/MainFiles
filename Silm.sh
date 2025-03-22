#!/bin/bash

# Запрашиваем у пользователя семь выборов
read -p "Выберите систему (например, x86_64): " choice1
read -p "Выберите количество ядер (например, 2): " choice2
read -p "Выберите сеть (например, user): " choice3
read -p "Выберите устройство (например, virtio-net-pci AC97 pcspk): " choice4
read -p "Выберите объем памяти (например, 2G): " choice5
read -p "Выберите CD-ROM (например, path/to/cdrom.iso): " choice6
read -p "Выберите жесткий диск (например, path/to/disk.img): " choice7

# Формируем команду qemu-system-
command="qemu-system-$choice1 -smp $choice2 -net $choice3 -device $choice4 -m $choice5 -vnc localhost:0 -cdrom $choice6 -hda $choice7"

# Выполняем команду
echo "Выполняемая команда: $command"
eval $command

echo "Команда завершена VNC= localhost:0."
