#!/bin/bash

#判断netdata是否安装且启动
ps -ef|grep -v grep|grep netdata ||exit 0
#获取路径
netdataPath=$(cat /proc/$(ps -ef|grep -v grep|grep netdata.pid|awk '{print$2}')/cmdline| awk '{split($0,arr,"/"); print "/"arr[2]"/"arr[3]}')
fileName=$(find $netdataPath -name 'dashboard_info.js'|grep -v chinese)
filePath=$(dirname $fileName)
#替换文件
mkdir bak
for file in dashboard_info.js dashboard.js index.html main.js
do
mv ${filePath}/${file} bak/
done
cp netdata-chinese/* $filePath/
#修改文件属组
#chown netdata:netdata $filePath/*
