#!/bin/bash

if ! command -v yq &> /dev/null; then
  echo "Please install yq: https://github.com/mikefarah/yq";
  exit 1;
fi

NETWORKS=()


for FILE in $(ls **/docker-compose.yml); do
  yq e '.networks | to_entries[] | select(.value.external == true) | .key' "$FILE"
done
