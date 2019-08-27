#!/usr/bin/env bash

for each in job-mttrain5*.yaml; do
    kubectl create -f $each
done
