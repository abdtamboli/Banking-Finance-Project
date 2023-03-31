#!/usr/bin/env bash


export KUBECONFIG=/var/jenkins_home/workspace/Banking-capstone-project/Terraform/lke-cluster-config.yaml
kubectl get node
kubectl create namespace test
kubectl create secret generic myregcred -n test \
--from-file=.dockerconfigjson=/var/jenkins_home/.docker/config.json \
--type=kubernetes.io/dockerconfigjson
export K8S_AUTH_KUBECONFIG=/var/jenkins_home/workspace/Banking-capstone-project/Terraform/lke-cluster-config.yaml