#!/bin/bash
COUNT="999"
opt=s5
interval=30
s5timer=180
cycle=$(<${opt}_cycle.txt)
LOG=$(<${opt}_log.txt)

#update cycle
((cycle++))
echo "$cycle" > ${opt}_cycle.txt 

#keep wake
echo "*********************** S5 Cycle: $cycle *************************" |tee -a ${LOG}
echo `date +%Y-%m-%d' '%H:%M:%S` "Going to S5 after "$interval" sec" |tee -a ${LOG}
sleep $interval

sudo rtcwake -m off -s $s5timer >> ${LOG} 2>&1




