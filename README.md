# localstack-sidecar

Localstack-sidecar is a tiny image that wraps AWS client and provides a solution to run initialisation scripts for any LocalStack service.
This docker image will run as a sidecar container. 
It will wait until the host specified with LISTENING_HOST environment variable will have the port open (specified with LISTENING_PORT environment variable)
It will then execute an arbitrary set of scripts (ending with the extension .sh ) which should be placed in a folder that will be mounted as volume.

Better README TBD. In the meantime check the example folder.