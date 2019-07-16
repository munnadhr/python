#!/bin/bash

export Project=$1
export Bucket="$2"
export Dataset=$3
export Table=$4
current_project=$(gcloud config get-value project)
gcloud auth activate-service-account terraform@openshift.iam.gserviceaccount.com --key-file=$5 --project=$Project
if [ $? -eq 0 ];then
        echo "Service account terraform@openshift.iam.gserviceaccount.com is activated on $Project"
else
        echo "Service account is not activated"
        exit
fi

function bq_create() {
        bq mk $Dataset
        if [ $? -eq 0 ];then
            echo "Dataset $Dataset created under $Project"
            bq mk ${Dataset}.${Table}
            if [ $? -eq 0 ];then
                echo "Table $Table has been created under Dataset $Dataset"
            else
                echo "Table $Table is not created"
                exit
            fi
        else
            echo "Dataset $Dataset unable to create"
            exit
        fi
 }

if [ "$current_project" == "$Project" ];then
    bq_create
else
    gcloud config set project $Project
    bq_create
fi

#Load data to the Table
bq load --autodetect --source_format=CSV ${Dataset}.${Table} $Bucket 
