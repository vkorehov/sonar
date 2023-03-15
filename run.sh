#!/bin/bash

if grep -q 'sonar.lo$' /etc/hosts
then
    echo "sonar.lo is already mapped"
else
    echo "adding host record for sonar.lo"
    export MYIP=$(minikube ip)
    sudo bash -c "echo \"${MYIP} sonar.lo\" >>/etc/hosts"
fi
echo "point your browser at https://sonar.lo and accept self-signed certificate in your browser. initial credentials are admin/admin"
