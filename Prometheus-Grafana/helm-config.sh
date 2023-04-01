#!/usr/bin/env bash

export KUBECONFIG=/var/jenkins_home/workspace/Banking-capstone-project/Terraform/lke-cluster-config.yaml
kubectl get node
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install monitoring prometheus-community/kube-prometheus-stack -n monitoring
kubectl get all -n monitoring