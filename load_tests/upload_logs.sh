#!/bin/bash

BUCKET=$1
LOGDIR=$2

aws s3 cp $2 s3://$1 --recursive --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers
