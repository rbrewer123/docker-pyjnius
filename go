#!/bin/bash

# run the container as a user to simplify writing files outside the container
docker run --rm -it -v $PWD:/data rbrewer/pyjnius -U rbrewer -u 1000 -G rbrewer -g 1000 "$@"
