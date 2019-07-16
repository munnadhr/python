#!/bin/bash

export Project=$1
export Region=$2
current_project=$(gcloud config get-value project)
gcloud auth activate-service-account terraform@openshift.iam.gserviceaccount.com --key-file=$5

function bq_create() {
        bq mk $3
        if [ $? -eq 0 ];then
            echo "Dataset $3 created under $Project"
            bq mk $3.$4
            if [ $? -eq 0 ];then
                echo "Table $4 has been created under Dataset $3"
            else
                echo "Table $4 is not created"
                exit
            fi
        else
            echo "Dataset $3 unable to create"
            exit
        fi
 }

if [ "$current_project" == "$Project" ];then
    bq_create
else
    gcloud config set project $Project
    bq_create
fi
    
