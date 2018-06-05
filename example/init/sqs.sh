#!/bin/sh
set -e

aws --endpoint-url http://localstack:4576 sqs create-queue --queue-name a-sample-queue-name

