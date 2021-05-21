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

pod repo bump $VERSION

git add .
git commit -m "Bump version to $VERSION"
git tag -f $VERSION
git push origin :refs/tags/$VERSION
git push origin main
git push origin $VERSION
