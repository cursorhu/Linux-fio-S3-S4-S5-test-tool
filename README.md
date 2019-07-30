# 1.Introduction
This Linux stress test tool is tested on Ubuntu, and support following test items:  
  *Hard disk/USB device read/write test  
  *Sytem suspend and resume test  
  *System hibernate and resume test  
  *System restart test  

# 2.preparation
*install fio  
to use apt-get install command from ubuntu repositories in China, you must choose a repositories source that is not blocked  
  software & updating -> choose to download from china mirror site -> update repositories
then you can install fio test tool
  apt-get install fio
*enable hibernate using swapfile
ubuntu create a default swapfile in root path when system is installed  
It's recommanded to resize the swapfile to the size of RAM, for example, if your RAM size is 4GB
   swapoff /swapfile
   dd if=/dev/zero of=/swapfile bs=1024M count=4
   chmod 600 /swapfile
   mkswap /swapfile
   swapon /swapfile
to hibernate and resume from swapfile, you must config grub file of device UUID and offset and size of swapfile  
use df -h to find your filesystem name, use blkid to find corresponding UUID value, use filefrag –v /swapfile to find offset of swapfile
