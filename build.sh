#!/bin/bash -ex

(cd tap && gradle clean assemble javadoc build test)
cp tap/build/libs/*.war docker/tap

(cd docker/tap && docker build . -t lsstdax/tap-postgres:dev)
