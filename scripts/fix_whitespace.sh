#!/bin/bash

# Script to remove trailing white from all files staged by git
# Get git root directory and cd into it
CURRENT_DIR=$(pwd)
GIT_ROOT=$(git rev-parse --show-toplevel)

cd $GIT_ROOT

FILES=$(git diff --name-only --staged)

for f in $FILES; do
	sed -i 's/ *$//g' $f
	git add $f
done

cd $CURRENT_DIR
