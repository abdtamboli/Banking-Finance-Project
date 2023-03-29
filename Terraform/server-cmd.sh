#!/usr/bin/env bash

export KUBE_VAR=`terraform output kubeconfig` && echo $KUBE_VAR | base64 -di > lke-cluster-config.yaml
export KUBECONFIG=lke-cluster-config.yaml