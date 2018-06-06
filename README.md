
# localstack-sidecar

Localstack-sidecar aims to solve the **wait to be ready** problem with docker-compose.

## Problem
In most cases an application relies on a database, queue or any other third party dependencies. Usually the application expects that these dependencies are already configured correctly and therefore it does not attempt to initialize its dependencies every time it starts up.

This scenario is usually common when the application runs in a shared environment (ie: staging, production) but it is not valid when the application and its dependencies are run locally.

docker-compose does most of the heavylifting: it allows to create a dependency graph using  **depends_on** or **link** and by using those instruction it is possible to have sidecar containers to provide some scripts to  initialise a depencency.

However,for obvious reason, it cannot guarantee that a given service running in a container is actually up and running and can accept requests.

## the sidecar project  

It is a tiny Docker image that wraps AWS client and provides a solution to run initialisation scripts for any LocalStack service.

This docker image will run as a sidecar container. It will wait until the host specified with **LISTENING_HOST** environment variable will have the port open (specified with **LISTENING_PORT** environment variable)

It will then execute an arbitrary set of scripts which should be placed in a folder that will be mounted as volume to **/opt/init**.

Please note that scripts **must have** the **.sh extension** and must be **executable**	

### docker-compose example

To have an idea on how to use it please refer to the example folder.
Below the docker-compose used in the example.


    version: '2.1'
    services:
    localstack:
        image: localstack/localstack
        ports:
          - "4576:4576"
          - "${PORT_WEB_UI-8080}:${PORT_WEB_UI-8080}"
        environment:
          - "SERVICES=sqs"
          - "DEFAULT_REGION=eu-west-1"
          - "HOSTNAME=${LOCALSTACK_HOSTNAME:-localhost}"
          - "HOSTNAME_EXTERNAL=${LOCALSTACK_HOSTNAME_EXTERNAL:-localhost}"

    create_localstack_resources:
        image: quay.io/signal/localstack-sidecar:0.1
        environment:
          #if localstack uses proxy mode (enabled by default) the internal service port should be specified.
          - LISTENING_PORT=4561 
          - LISTENING_HOST=localstack
        depends_on:
          - localstack
        links:
          - "localstack"
        volumes:
          - "./init:/opt/init"


