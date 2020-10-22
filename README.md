# Big Data Ops

Very simply combines Daskhub (https://github.com/dask/helm-chart/tree/master/daskhub) and Spark (Livy) (https://github.com/JahstreetOrg/spark-on-kubernetes-helm) into a single uber helm chart which allows you to spin up either one.  End result is a jupyterhub that allows you to use either dask or spark for backend computations on kubernetes.  All credit goes to respective maintainers of those repos.

Will expand to have more capability later.

## Prerequisites:
- Kubernetes/kubectl
- Helm

## Run
run `scripts/start.sh`

Future Direcitons:
1.  Combine pangeo/base-notebook image and sasnouskikh/jupyter:4.6.3-sparkmagic so there is a single unified image that can do both dask and spark
2.  Build libraries that infer whether to use (None, Dask, or Spark) depending on the characteristics of the underlying operation and uses https://pypi.org/project/dask-sql/ and SparkSQL to combine the interface.
3.  Mix in some more IAM capability for AWS for example kube2iam.
