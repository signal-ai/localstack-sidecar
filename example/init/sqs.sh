#!/bin/sh
set -e

aws --endpoint-url http://localstack:4576 sqs create-queue --queue-name prod-pipeline-vulcan-builder-in
aws --endpoint-url http://localstack:4576 sqs create-queue --queue-name prod-pipeline-vulcan-topic-builder-in
