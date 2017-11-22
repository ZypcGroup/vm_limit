#!/bin/bash
for ((cpu_limit=8400; cpu_limit>=2000; cpu_limit=cpu_limit-200))
do
for ((memory_limit=65536; memory_limit>2048; memory_limit=memory_limit-2048))
do
for ((disk_iops=150; disk_iops>10; disk_iops=disk_iops-5))
do
for((j=3;j>0;j--))
do
echo $cpu_limit$memory_limit$disk_iops
./change_vm hadoop-master $cpu_limit $memory_limit $disk_iops
./change_vm hadoop-slave1 $cpu_limit $memory_limit $disk_iops
./change_vm hadoop-slave2 $cpu_limit $memory_limit $disk_iops
echo -ne $cpu_limit" "$memory_limit" "$disk_iops"\t" >> /home/xiyounet/performance.txt
ssh -n 192.168.230.248 /root/1.bash
scp 192.168.230.248:/root/hpc.txt /home/xiyounet/temp.txt
mapper_time=`cat /home/xiyounet/temp.txt |egrep "time [a-z ]* slots" |cut -d "=" -f 2|sed '1d'`
reduce_time=`cat /home/xiyounet/temp.txt |egrep "time [a-z ]* slots" |cut -d "=" -f 2|sed '2d'`
let all_time=mapper_time+reduce_time
echo $mapper_time" "$reduce_time" "$all_time >> /home/xiyounet/performance.txt
done
done
done
done
