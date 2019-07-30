#!/bin/bash
DIR=$1
loop=1
while true;do
	echo `date +%Y-%m-%d' '%H:%M` "**************** fio loop: $loop ****************" 
	fio -directory=$DIR -direct=1 -iodepth 16 -thread -rw=randread -ioengine=psync -bs=4k -size=32M -runtime=60 -numjobs=32 -name=randread -group_reporting 
	fio -directory=$DIR -direct=1 -iodepth 16 -thread -rw=randwrite -allow_mounted_write=1 -ioengine=psync -bs=4k -size=32M -runtime=60 -numjobs=32 -name=randwrite -group_reporting 
	fio -directory=$DIR -direct=1 -iodepth 16 -thread -rw=randrw -rwmixread=50 -allow_mounted_write=1 -ioengine=psync -bs=4k -size=32M -runtime=60 -numjobs=32 -name=randrw -group_reporting
	loop=$(($loop + 1))
done
