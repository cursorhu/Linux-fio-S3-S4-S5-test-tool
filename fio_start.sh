#!/bin/bash

if [ !"$1" ];then
    echo "usage: ./start_fio.sh mount_path"
    echo "using default root path: /"
    DIR="/"
else
    DIR=$1
fi

mkdir -p log
DATE=$(date +%Y-%m-%d)
LOG=log/fio_${DATE}.log
. ./fio.sh $DIR > $LOG 2>&1 &
tail -f $LOG
