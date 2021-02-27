# Pyspark Example Pipeline using Google Cloud Dataproc

## Prerequisite
```
Python >=3.6   
Google Cloud Platform
```

## Please following below, 

1. Create bucket for initialization actions, Then copy install script to bucket

```shell
gsutil mb <bucket_name>
gsutil cp initz_action/install.sh gs://<bucket_name>
```

2. Enable Dataproc API Service   
3. Enable BigQuery API Service


4. Generate mockup data
```shell
python generator_sentance.py 
```
You will receive new text file, Then copy the file to GCS
```shell
gsutil cp text_sample.txt gs://<bucket_name>/text_sample.txt
```

5. Create Dataproc cluster, Just waiting until the cluster has created.
```shell
bash dataproc_cluster_scripts/create.sh --cluster_name <CLUSTER_NAME> --region <REGION> --gcs_uri <INITIALIZATION_ACTION_GCS_LOCATION>
```

For instance, 

```shell
bash dataproc_cluster_scripts/create.sh --cluster_name bozzlab-spark-cluster --region asia-southeast1 --gcs_uri gs://<bucket_name>/initz_action/install.sh
```

6. Assign for Python enviroment
```shell
export DRIVER=yarn # if you want to run on local development please assign "local" to DRIVER
export PROJECT_ID=<PROJECT_ID> # The Google Cloud Project ID
export DATASET=<DATASET> # The Dataset name on BigQuery
export TABLE=<TABLE> # The Table name on BigQuery
```

7. Submit Pyspark job to Dataproc
```
bash exec.sh --cluster_name <CLUSTER_NAME> --region <REGION> --gcs_uri <gs://<bucket_name>/text_sample.txt>
```

For instance, 

```shell
bash dataproc_cluster_scripts/create.sh --cluster_name bozzlab-spark-cluster --region asia-southeast1 --gcs_uri gs://<bucket_name>/text_sample.txt
```

8. (Optional) Delete Cluster

```shell
bash dataproc_cluster_scripts/delete.sh --cluster_name <CLUSTER_NAME> --region <REGION> 
```

For instance, 

```shell
bash dataproc_cluster_scripts/delete.sh --cluster_name bozzlab-spark-cluster --region asia-southeast1
```