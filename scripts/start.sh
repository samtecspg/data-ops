#!/bin/bash

helm repo add spark-cluster https://jahstreet.github.io/helm-charts
helm repo add daskhub https://helm.dask.org
helm repo update
helm dependency update

export API_TOKEN=$(openssl rand -hex 32)

helm upgrade --install data-ops . --set daskhub.jupyterhub.hub.cookieSecret=${API_TOKEN} --set daskhub.jupyterhub.proxy.secretToken=${API_TOKEN} --set daskhub.jupyterhub.proxy.service.type=LoadBalancer --set daskhub.jupyterhub.hub.services.dask-gateway.apiToken=${API_TOKEN} --set spark-cluster.jupyterhub.proxy.secretToken=${API_TOKEN} --set daskhub.dask-gateway.gateway.auth.jupyterhub.apiToken=${API_TOKEN} --set spark-cluster.tags.jupyterhub=true --set spark-cluster.jupyterhub.proxy.service.type=LoadBalancer --set daskhub.jupyterhub.proxy.service.type=LoadBalancer


