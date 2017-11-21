#!/bin/bash
start_bw=1000;
./network_vm hadoop-master $start_bw
./network_vm hadoop-slave1 $start_bw
./network_vm hadoop-slave2 $start_bw
echo -e "" >> /home/xiyounet/network.txt
echo -e $i"\t" >> /home/xiyounet/network.txt
ssh -n 192.168.230.248 /root/1.bash
scp 192.168.230.248:/root/hpc.txt /home/xiyounet/temp.txt
i=`cat /home/xiyounet/temp.txt |egrep "time [a-z ]* slots" |cut -d "=" -f 2|sed '1d'`
let i=i+`cat /home/xiyounet/temp.txt |egrep "time [a-z ]* slots" |cut -d "=" -f 2|sed '2d'`
echo $i >> /home/xiyounet/network.txt
