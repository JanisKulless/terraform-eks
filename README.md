# CHANGELOG

* Added VAULT
* Added s3 Bucket as mountable volume
* Added manifests for s3s fuse configuration

# HOW TO USE

1) Clone repo and go inside main folder
2) Run **terraform int**. If it fails because you are using Terraform 14 go to **/.terraform/modules/** in cloned project folder, find respective module and uncomment version constraints in **versions.tf**
3) Install and configure **aws** & **kubectl**
4) Generate hex values by running command: **openssl rand -hex 32**.
5) In **helm** folder edit **values.yml** file and paste generated hex. Use **values.yml** to add more config.
6) Edit **manifests.tf** according to your s3 bucket and AWS key data.
7) Edit **vault/values.yml** and add info about your bucket.
8) Run **terraform apply**. Resource creation should take approx 10 - 15 minutes.
9) Script should print out j-hub address. If not, proceed with **aws eks --region eu-central-1 update-kubeconfig --name test-cluster** and **kubectl --namespace=default get svc proxy-public**.
11) Password and login is kept in values.yml file. By default: **admin** and **supersecretpassword!**.
12) Vault UI is accessible by running **kubectl port-forward vault-primary-0 8200:8200** and then going to **http://127.0.0.1:8200/** in your browser.
13) As for now s3 bucket is possible to access going root in Jupyterhub notebook terminal, by running **sudo su -** and then navigating to **/home/jovian/shared/**
14) To clean up run **terraform destroy**.

![alt text](https://github.com/JanisRancans/terraform-eks/blob/main/jhub-running-python.png?raw=true)
