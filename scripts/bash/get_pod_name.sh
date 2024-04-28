#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <pod_name>"
	exit 1
fi

search_string="$1"

k get pods | grep $search_string | awk '{print $1}'
