#!/bin/bash

sudo apt-get install siege=3.0.8-1 -y
sudo apt-get install jq -y

#Geting the nodeport value for the service
#nodeport=`kubectl get svc/frontend -n production -ojson|jq '.spec.ports|.[]|.nodePort'`

echo "siege (For Generating HTTP) is running and waiting for some time"
echo "----------------------------------------------------------------"
#Generating load
#Currently hardcoding it to prod FQDN
siege -c 1000 guestbook.mstakx.io & echo $! > ~/pid
ps -ef|grep siege

#Monitoring CPU and Replica count during load
for i in 1 2 3 4 5
do
echo "$i)waiting for 30 secs to monitor the upscale of pods after generating load"
echo -e "--------------------------------------------------------------------------------------\n"
sleep 30
cpu=`kubectl get hpa -n production -ojson | jq '.items|.[]|.status.currentCPUUtilizationPercentage'`
replicas=`kubectl get hpa -n production -ojson | jq '.items|.[]|.status.currentReplicas'`
echo -e "-------------------------------"
echo -e "CPUUtilization during load: $cpu"
echo -e "-------------------------------\n"
echo -e "-------------------------------"
echo -e "Replica count during load: $replicas"
echo -e "-------------------------------\n"
done

#Stoping the load
echo "Stoping the HTTP load on pods......."
processid=`cat ~/pid`
kill -9 $processid

#Monitoring CPU and Replica count after load
for i in 1 2 3 4 5
do

echo "$i)waiting for 30 secs to monitor the downscale of pods after finishing load"
echo "---------------------------------------------------------------------------------------"
sleep 30
cpu=`kubectl get hpa -n production -ojson | jq '.items|.[]|.status.currentCPUUtilizationPercentage'`
replicas=`kubectl get hpa -n production -ojson | jq '.items|.[]|.status.currentReplicas'`
echo -e "-------------------------------"
echo -e "CPUUtilization after load: $cpu"
echo -e "-------------------------------\n"
echo -e "-------------------------------"
echo -e "Replica count after load: $replicas"
echo -e "-------------------------------\n"

done

