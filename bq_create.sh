#!/bin/bash

export Project=$1
export Region=$2

bq mk $1
if [ $? -eq 0 ];then
    echo "Dataset created under $Project"
    bq mk $3.$4
    if [ $? -eq 0 ];then
        echo "Table has been created under Dataset"
    else
        echo "Table is not created"
        exit
    fi
else
    echo "Dataset unable to create"
    exit
fi
