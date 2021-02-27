#!/bin/bash

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help) echo "Please assign --cluster_name <cluster_name> --region <region> --gcs_uri <gcs_location_input_file>"; exit 1;;
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

gcloud dataproc jobs submit pyspark main.py \
--cluster=$cluster_name\
--region=$region \
-- $gcs_uri