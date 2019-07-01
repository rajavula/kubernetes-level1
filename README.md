#################################
GCP setup for clusterrolebinding
##################################

$ ACCOUNT=$(gcloud info --format='value(config.account)')
$ kubectl create clusterrolebinding owner-cluster-admin-binding --clusterrole cluster-admin --user $ACCOUNT



Assumptions 
- Environment should be in user mode





