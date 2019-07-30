#!/bin/bash
#grep -v grep: skip kill grep itself
#awk: select fio PIDs
#xargs: pass all awk output as input parameters(PID) of 'kill -9'
ps -ef | grep run_fio.sh | grep -v grep | awk '{print $2}'| xargs kill -9 > /dev/null 2>&1
ps -ef | grep fio | grep -v grep | awk '{print $2}'| xargs kill -9 > /dev/null 2>&1
