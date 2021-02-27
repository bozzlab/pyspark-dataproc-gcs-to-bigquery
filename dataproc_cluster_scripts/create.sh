#!/bin/bash

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help) echo "Please assign --cluster_name <cluster_name> --region <region> --gcs_uri <initialization_action_location>"; exit 1;;
        -c|--cluster_name) cluster_name="$2"; shift ;;
        -r|--region) region="$2"; shift ;;
        -g|--gcs_uri) gcs_uri="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

[ -z $cluster_name ] && echo "--cluster_name is missing"
[ -z $region ] && echo "--region is missing"
[ -z $gcs_uri ] && echo "--gcs_uri is missing"

gcloud dataproc clusters $cluster_name \
    --image-version=1.5 \
    --master-machine-type n1-standard-2 \
    --master-boot-disk-size 20GB \
    --region=$region \
    --num-workers 2 \
    --worker-boot-disk-size 20GB \
    --worker-machine-type n1-standard-2 \
    --metadata='PIP_PACKAGES=pandas==1.2.2 pandas-gbq==0.14.1' \
    --initialization-actions=$gcs_uri