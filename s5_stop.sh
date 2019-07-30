#!/bin/bash
USER=$(users)
opt=s5
rm -f /home/$USER/.config/autostart/s5.desktop
rm -f ${opt}_cycle.txt ${opt}_log.txt
sed -i '/NOPASSWD/d' /etc/sudoers
