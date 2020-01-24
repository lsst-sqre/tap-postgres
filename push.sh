#!/bin/bash -e
TAG=${1:?'You must specify the image tag to push'}

if [ $TAG == "dev" ]; then
  echo "Don't try to push the dev tag.  Dev is only for local testing."
  exit 1
fi

# Replace /'s in branch names with underscores, since you can't
# have a / in a docker tag.
TAG=`echo "$TAG" | tr / _`

echo "Pushing all images with tag $TAG"

docker tag lsstdax/tap-postgres-server:dev lsstdax/tap-postgres-server:$TAG
docker tag lsstdax/tap-postgres-db:dev lsstdax/tap-postgres-db:$TAG

docker push lsstdax/tap-postgres-server:$TAG
docker push lsstdax/tap-postgres-db:$TAG
