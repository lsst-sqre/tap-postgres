#!/bin/bash -ex
if [ -f dev-chart.tgz ]
then
  CHART=dev-chart.tgz
else
  CHART=lsst-sqre/cadc-tap-postgres
fi

helm delete obstap-dev -n obstap-dev || true

./build.sh
helm upgrade --install obstap-dev $CHART --create-namespace --namespace obstap-dev --values dev-values.yaml
