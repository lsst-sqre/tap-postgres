#!/bin/bash -ex

(cd tap && gradle clean assemble javadoc build test)
cp tap/build/libs/tap-1.1.war docker/tap/tap.war

(cd docker/tap && docker build . -t lsstdax/tap-postgres-service:dev)
(cd docker/cadc-postgresql-dev && docker build . -f Dockerfile.pg15 -t lsstdax/tap-postgres-db:dev)
(cd docker/uws && docker build . -t lsstdax/tap-postgres-uws:dev)
