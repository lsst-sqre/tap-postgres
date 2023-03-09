#!/bin/bash

# Build the WAR file that will be installed in the Docker image.

set -exo pipefail

cd tap

# Build the TAP service and docker images.
gradle --stacktrace --info clean assemble javadoc build test
cp build/libs/*.war ../docker/tap
