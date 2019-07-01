################################################################################################
If you are testing this on Google Cloud Platform, Need to do clusterrolebinding in GCP Cluster
################################################################################################

$ ACCOUNT=$(gcloud info --format='value(config.account)')
$ kubectl create clusterrolebinding owner-cluster-admin-binding --clusterrole cluster-admin --user $ACCOUNT



Assumptions 
- You have Kubernetes Cluster on GCP
- Clone the git
- Environment should be in user mode
- Run the initstep.sh
- Before you test Nignx ingress controller functionality, you need to keep External IP in /etc/hosts file since we have not setup DNS.
- Make sure Metrics pod running on kubernetes cluster before implementing Horizontal Auto Scale up / down







