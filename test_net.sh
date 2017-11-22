#!/bin/bash
for ((start_bw=1000; start_bw>=50; start_bw=start_bw-50))
do
for((j=3;j>0;j--))
do
./network_vm hadoop-master $start_bw
./network_vm hadoop-slave1 $start_bw
./network_vm hadoop-slave2 $start_bw
echo -ne $start_bw"\t" >> /home/xiyounet/network.txt
ssh -n 192.168.230.248 /root/1.bash
scp 192.168.230.248:/root/hpc.txt /home/xiyounet/temp.txt
i=`cat /home/xiyounet/temp.txt |egrep "time [a-z ]* slots" |cut -d "=" -f 2|sed '1d'`
let i=i+`cat /home/xiyounet/temp.txt |egrep "time [a-z ]* slots" |cut -d "=" -f 2|sed '2d'`
echo $i >> /home/xiyounet/network.txt
done
done
