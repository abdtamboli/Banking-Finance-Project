#!/usr/bin/env bash

export KUBECONFIG=/var/jenkins_home/workspace/Banking-capstone-project/Terraform/lke-cluster-config.yaml
kubectl get node
kubectl get all