#!/bin/bash -ex

(cd tap && gradle clean assemble javadoc build test)
cp tap/build/libs/*.war docker

(cd docker && docker build . -t lsstdax/tap-postgres:dev -f Dockerfile.tap)
