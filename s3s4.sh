#! /bin/bash

if [ $# -ne 2 ];then
	echo "usage:"
	echo "s3: ./s3s4.sh s3 count"
	echo "s4: ./s3s4.sh s4 count"
	exit 1
fi

opt=$1
COUNT=$2
interval=30
s3timer=120
s4timer=120

mkdir -p log
DATE=$(date +%Y-%m-%d)
LOG=log/${opt}_${DATE}.log
cat /dev/null > ${LOG}

echo "=============================== $opt test start ===============================" |tee -a ${LOG}

for (( i=1; i<=$COUNT; i++ ))
do 
	if [ $opt == "s3" ];then
		echo "************************* S3 Cycle: $i start *************************" |tee -a ${LOG}
		echo `date +%Y-%m-%d' '%H:%M:%S` "Going to S3, Duration "$s3timer" sec" |tee -a ${LOG}
		sudo rtcwake -m mem -s $s3timer >> ${LOG} 2>&1
		echo `date +%Y-%m-%d' '%H:%M:%S`" Waitable timer triggered." |tee -a ${LOG}
		echo `date +%Y-%m-%d' '%H:%M:%S`" Wake up from S3, Cycle "$i"" |tee -a ${LOG}
		echo `date +%Y-%m-%d' '%H:%M:%S`" Successfully left sleep state S3..." |tee -a ${LOG}
	elif [ $opt == "s4" ];then
		echo "************************* S4 Cycle: $i start *************************" |tee -a ${LOG}
		echo `date +%Y-%m-%d' '%H:%M:%S` "Going to S4, Duration "$s4timer" sec" |tee -a ${LOG}
		sudo rtcwake -m disk -s $s4timer >> ${LOG} 2>&1
		echo `date +%Y-%m-%d' '%H:%M:%S`" Waitable timer triggered." |tee -a ${LOG}
		echo `date +%Y-%m-%d' '%H:%M:%S`" Wake up from S4, Cycle "$i"" |tee -a ${LOG}
		echo `date +%Y-%m-%d' '%H:%M:%S`" Successfully left sleep state S4..." |tee -a ${LOG}
	else
		echo "error input, use s3 or s4 as input"
	fi
	echo `date +%Y-%m-%d' '%H:%M:%S` "wake up for $interval seconds" |tee -a ${LOG}
	echo "************************* $opt Cycle: $i finish *************************" |tee -a ${LOG}
	#keep wake up time
	sleep $interval
done

echo "=============================== $opt test finished =============================== " |tee -a ${LOG}
