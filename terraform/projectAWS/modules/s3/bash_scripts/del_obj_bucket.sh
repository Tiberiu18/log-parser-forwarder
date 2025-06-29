#!/bin/bash
BUCKET="tibi-bucket-29062025"

echo "Removing all versions..."
VERSIONS=$(aws s3api list-object-versions --bucket $BUCKET --query '{Objects: Versions[].{Key:Key,VersionId:VersionId}}' --output json)

if [ "$VERSIONS" != '{"Objects":[]}' ]; then
  aws s3api delete-objects --bucket $BUCKET --delete "$VERSIONS"
fi

echo "Deleting delete markers..."
DELETES=$(aws s3api list-object-versions --bucket $BUCKET --query '{Objects: DeleteMarkers[].{Key:Key,VersionId:VersionId}}' --output json)

if [ "$DELETES" != '{"Objects":[]}' ]; then
  aws s3api delete-objects --bucket $BUCKET --delete "$DELETES"
fi

