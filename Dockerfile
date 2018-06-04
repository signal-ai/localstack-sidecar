FROM alpine:3.6

# Versions: https://pypi.python.org/pypi/awscli#downloads

RUN apk --no-cache update && \
    apk --no-cache add python py-pip py-setuptools ca-certificates groff less && \
    pip --no-cache-dir install awscli && \
    rm -rf /var/cache/apk/*

WORKDIR /data

RUN mkdir /root/.aws
COPY ./aws/credentials /root/.aws
COPY ./aws/config /root/.aws

# Deploy startup script and Create folder for custom scripts
COPY ./bin/run-all.sh /usr/local/bin/run-all
COPY ./bin/start.sh /usr/local/bin/start
RUN chmod 777 /usr/local/bin/run-all
RUN chmod 777 /usr/local/bin/start

ENTRYPOINT ["start"]
