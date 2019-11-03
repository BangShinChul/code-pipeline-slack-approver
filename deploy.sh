#!/bin/bash

set -eu

CONF=${1:-deploy.conf}

source $CONF

rm -rf target

mkdir target
zip -r target/app.zip ./app

sam package --template-file template.yml --output-template-file target/packaged.yml --s3-bucket sam-artifacts-524176662322-ap-northeast-1
sam deploy --template-file target/packaged.yml --stack-name code-pipeline-slack-approver --capabilities CAPABILITY_IAM --parameter-overrides $PARAMS
