Task 1 - Implementing / deploying the enviromnent.

Please use initsetup.sh to deploy environment. initsetup.sh will implement Ingress Nginx cluster, insert External IP to /etc/hosts, create namespaces, installs guest-book in both namespaces, Exposes Ingress, Implements Horizontal Auto Scale

Task 2 - Testing the load test in both Production and Staging namespaces (Step4 should be pre-requisite for this)

loadtest_production.sh , loadtest_staging.sh - 

  these script(s) will do load test, We have minimum replicas # 3 and maximum # 5 and CPU utilization Percentage as 10%.
In loadtest script, we used siege to increase the HTTP requests on pods which will increase load on pods, Once load crosses 10% pods will reach to maximum replicas number.
  After that we have stopped the seige script, so that load will become normal, then auto scaler will make sure pods number reached to minimum pods.



Assumptions - 

Step 1 - You have Kubernetes Cluster on GCP

Note - pre-requisite for GCP cluster is clusterrolebinding in GCP kubernetes Cluster

$ ACCOUNT=$(gcloud info --format='value(config.account)')
$ kubectl create clusterrolebinding owner-cluster-admin-binding --clusterrole cluster-admin --user $ACCOUNT


Step2 -  Clone the git

Step3 - Environment should be in user mode

Step4 - Make sure Metrics-Server pod running on kubernetes cluster before implementing Horizontal Auto Scale up / down







