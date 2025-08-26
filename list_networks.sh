#!/bin/bash

if ! command -v yq &> /dev/null; then
  echo "Please install yq: https://github.com/mikefarah/yq";
  exit 1;
fi

FILES=$(ls **/docker-compose.yml)

NETWORKS=()


for FILE in $FILES; do
  NETWORKS+=$(yq e '.networks | to_entries[] | select(.value.external == true) | .key' "$FILE")
done

echo FILE
