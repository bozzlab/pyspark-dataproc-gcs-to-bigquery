#!/bin/bash

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help) echo "Please assign --cluster_name <cluster_name> --region <region>"; exit 1;;
        -c|--cluster_name) cluster_name="$2"; shift ;;
        -r|--region) region="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

[ -z $cluster_name ] && echo "--cluster_name is missing"
[ -z $region ] && echo "--region is missing"

gcloud dataproc clusters delete $cluster_name --region=$region