# SonarQube installation into minikube on Debian 11



## Pre-Requisites

Debian 11 Machine with at least 8GB of RAM and 20Gb of Disk

You have two options to install required tools:



## Option A: Clean Debian 11 Machine (Bullseye)

1. Checkout repo and cd into it.

2. Run this command as `non-elevated` user:

```

./install-tools-debian11.sh

```

## Option B: Install required tools yourself on linux of your choice

1. Checlout repo and cd into it

2. Install yourself:

```

Minikube version v1.29.0

Docker version 5:23.0.1-1

Helm version v3.11.2

Terraform version 1.4.0

Kubectl version v1.26.2

```

# Start minikube

```

minikube start

minikube addons enable ingress

```

# Deploy using terraform

```

terraform init

terraform plan

terraform apply

```

# Sanity check

Either execute yourself:

```

export MYIP=$(minikube ip)

sudo bash -c "echo \"${MYIP} sonar.lo\" >>/etc/hosts"

```

Then point your browser at https://sonar.lo and accept self-signed certificate in your browser.



`Or` simply execute and follow the instructions:

```

./run.sh

```

Initial credentials for sonarqube are `admin/admin`
