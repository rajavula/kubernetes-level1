#!/bin/sh

################# First cloning git ####################

git clone https://github.com/rajavula/kubernetes-level1
cd kubernetes-level1/
sleep 5

################## Creating Igress Nginx Controller and its service #######################
kubectl create -f deploy/nginx-controller-setup/nginx-ingress-controller.yaml
sleep 30
kubectl get pods -n ingress-nginx
kubectl create -f deploy/nginx-controller-setup/nginx-ingress-service.yaml
sleep 30
kubectl get service -n ingress-nginx
sleep 3

################## Keeping the External IP in /etc/hosts file #################
host=$(hostname -f)
ext_ip=$(kubectl get svc -n ingress-nginx | grep ingress-nginx | awk '{print $4}')
entry_var="$ext_ip $host"
echo $entry_var
sudo -- sh -c -e "echo '$entry_var' >> /etc/hosts"


################## Creating names spaces for guest-book application ####################

kubectl create namespace staging
kubectl create namespace production

######### Creting Guest-book application  on Produciton namespace

kubectl create -f deploy/guestbook/redis-master-deployment.yaml -n production
sleep 30
kubectl get pods -n production
kubectl create -f  deploy/guestbook/redis-master-service.yaml -n production
sleep 30
kubectl get service -n production
kubectl create -f deploy/guestbook/redis-slave-deployment.yaml -n production
sleep 30
kubectl get pods -n production
kubectl create -f deploy/guestbook/redis-slave-service.yaml -n production
sleep 30
kubectl get service -n production
kubectl create -f deploy/guestbook/frontend-deployment.yaml  -n production
sleep 30
kubectl get pods -l app=guestbook -l tier=frontend  -n production
kubectl create -f deploy/guestbook/frontend-service.yaml -n production
sleep 30
kubectl get service -n production


############  Display of created objects in production namespace

kubectl get all -n production



######### Creting Guest-book application  on Staging namespace

kubectl create -f deploy/guestbook/redis-master-deployment.yaml -n staging
sleep 30
kubectl get pods -n staging
kubectl create -f  deploy/guestbook/redis-master-service.yaml -n staging
sleep 30
kubectl get service -n staging
kubectl create -f deploy/guestbook/redis-slave-deployment.yaml -n staging
sleep 30
kubectl get pods -n staging
kubectl create -f deploy/guestbook/redis-slave-service.yaml -n staging
sleep 30
kubectl get service -n staging
kubectl create -f deploy/guestbook/frontend-deployment.yaml  -n staging
sleep 30
kubectl get pods -l app=guestbook -l tier=frontend  -n staging
kubectl create -f deploy/guestbook/frontend-service.yaml -n staging
sleep 30
kubectl get service -n staging


############  Display of objects in staging namespace

kubectl get all -n staging

############  Expose production application on hostname guestbook.mstakx.io ####################

kubectl create -f deploy/ingress-production/ingress-production.yaml -n production
sleep 30
kubectl get ingress -n production

#########################  Expose staging application on hostname staging-guestbook.mstakx.io #################

kubectl create -f deploy/ingress-staging/ingress-staging.yaml -n staging
sleep 30
kubectl get ingress -n staging

########## Implementing a pod autoscaler on both namespaces which will scale frontend pod replicas up and down based on CPU utilization of pods. 

kubectl create -f deploy/HorizontalAutoScale/hpa.yaml -n production
sleep 30
kubectl get hpa -n production


kubectl create -f deploy/HorizontalAutoScale/hpa.yaml -n staging
sleep 30
kubectl get hpa -n staging

##################    Environment setup completed, you can procced to test auto scale funtionality by running loadtest.sh  ###########
