#!/usr/bin/bash

CMD="docker image prune -a -f"

for node in $(kubectl get no --no-headers | awk '{print $1}'); do
    echo "now working on $node"
    ssh $node $CMD
done
