Assumptions - 
Step 1 - You have Kubernetes Cluster on GCP

################################################################################################
clusterrolebinding in GCP kubernetes Cluster
################################################################################################

$ ACCOUNT=$(gcloud info --format='value(config.account)')
$ kubectl create clusterrolebinding owner-cluster-admin-binding --clusterrole cluster-admin --user $ACCOUNT

Step2 -  Clone the git

Step3 - Environment should be in user mode

Step4 - Run the initstep.sh

Step5 - Make sure Metrics-Server pod running on kubernetes cluster before implementing Horizontal Auto Scale up / down







