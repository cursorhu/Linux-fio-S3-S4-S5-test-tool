#!/bin/bash
USER=$(users)
opt=s5
interval=30
s5timer=180

#config autostart
mkdir -p /home/$USER/.config/autostart
touch /home/$USER/.config/autostart/s5.desktop
echo "
[Desktop Entry]
Type=Application
Exec=gnome-terminal -e /home/$USER/s5.sh
Terminal=true
X-GNOME-Autostart-enabled=true
" > /home/$USER/.config/autostart/s5.desktop
chmod 777 /home/$USER/.config/autostart/s5.desktop
echo "config autostart finished"

#config sudo
echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#config s5 log and temp file 
mkdir -p log
DATE=$(date +%Y-%m-%d)
LOG=log/${opt}_${DATE}.log
cat /dev/null > ${LOG}
echo "1" > ${opt}_cycle.txt
echo "$LOG" > ${opt}_log.txt
chmod 777 -R ./*.sh ./log/*.log ./*.txt

echo "System will shutdown after "$interval" sec, then restart after "$s5timer" sec"
echo "*********************** S5 Cycle: 1 *************************" |tee -a ${LOG}
echo `date +%Y-%m-%d' '%H:%M:%S` "Going to S5 after "$interval" sec" |tee -a ${LOG}
sleep $interval

rtcwake -m off -s $s5timer >> ${LOG} 2>&1
