#!/bin/bash
# waitForContainersReady.sh
set -e

# Max query attempts before consider setup failed
MAX_TRIES=20

# Return true-like values if and only if logs
# contain the expected "ready" line
function tapIsReady() {
  docker-compose logs tap-service | grep "org.apache.catalina.startup.Catalina.start Server startup in"
}
function dbIsReady() {
  docker-compose logs tap-db | grep "listening"
}

function waitUntilServiceIsReady() {
  attempt=1
  while [ $attempt -le $MAX_TRIES ]; do
    if "$@"; then
      echo "$2 container is up!"
      break
    fi
    echo "Waiting for $2 container... (attempt: $((attempt++)))"
    sleep 5
  done

  if [ $attempt -gt $MAX_TRIES ]; then
    echo "Error: $2 not responding, cancelling set up"
    exit 1
  fi
}

waitUntilServiceIsReady tapIsReady "TAP Service"
waitUntilServiceIsReady dbIsReady "DB"
