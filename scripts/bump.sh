#!/bin/bash -e

set -ex

VERSION=$1

rx='^([0-9]+\.){0,2}(\*|[0-9]+)$'
if [[ $VERSION =~ $rx ]]; then
 echo "INFO:<-->Version $VERSION"
else
 echo "ERROR:<->Unable to validate package version: '$VERSION'"
 exit 1
fi

# Bump podspec version
pod repo bump $VERSION

# Commit changes
git add .
git commit -m "Bump version to $VERSION"
git tag -f $VERSION

# Delete legacy tag if needed
git push origin :refs/tags/$VERSION

# Push changes
git push origin main

# Push tag
git push origin $VERSION

# Publish pod to specs repo
pod repo push father --allow-warnings
