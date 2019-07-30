# 1.Introduction
This Linux stress test tool is tested on Ubuntu, and support following test items:  
  *Hard disk/USB device read/write test  
  *Sytem suspend and resume test  
  *System hibernate and resume test  
  *System restart test  

# 2.preparation
## install fio  
to use apt-get install command from ubuntu repositories in China, you must choose a repositories source that is not blocked  
```
    software & updating -> choose to download from china mirror site -> update repositories  
```
then you can install fio test tool  
```
    apt-get install fio
```
## enable hibernate using swapfile  
ubuntu create a default swapfile in root path when system is installed    
It's recommanded to resize the swapfile to the size of RAM, for example, if your RAM size is 4GB 
```
     swapoff /swapfile  
     dd if=/dev/zero of=/swapfile bs=1024M count=4  
     chmod 600 /swapfile  
     mkswap /swapfile  
     swapon /swapfile  
```
to hibernate and resume from swapfile, you must config grub file of device UUID and offset and size of swapfile.   
use `df -h` to find your filesystem name, use `blkid` to find corresponding UUID value, use `filefrag –v /swapfile` to find physical offset of swapfile
finally,modify `/etc/default/grub` as following
`GRUB_CMDLINE_LINUX_DEFAULT="quiet splash resume=UUID=your_UUID resume_offset=your_physical_offset"`
then update grub, and restart PC
`update-grub`

## disable updates and set auto-login
for S5(restart) test, unexpected updates may cause S5 fail to wakeup, and auto-login is necessary too  
disable updates:  
`gedit /etc/apt/apt.conf.d/20auto-upgrades`  
and set all values to 0

set auto-login:  
`gedit /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf`
```
user-session=ubuntu  
autologin-user=yourUserName  
```
`gedit /etc/gdm3/custom.conf`  
```
AutomaticLoginEnable = true  
AutomaticLogin = yourUserName  
```
# 3.run scripts
all script is recommanded to run at /home/yourUserName
## run fio
```
./fio_start.sh
```
## stop fio
```
./fio_stop.sh
```
## run S3/S4
./s3s4.sh option loops_you_need, for example:
```
./s3s4.sh s3 999
```
```
./s3s4.sh s4 999
```
## stop S3/S4
just turn off terminal
## run S5
```
./s5_start.sh
```
## stop S5
```
./s5_stop.sh
```
# logs
all logs are stored at log folder in script path in OPTION_DATA.log format
