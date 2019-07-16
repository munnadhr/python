#!/bin/bash

export Project=$1
export Region=$2

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
