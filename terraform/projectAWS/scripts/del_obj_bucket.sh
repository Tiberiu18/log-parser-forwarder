#!/bin/bash
BUCKET=$1

if [ "$#" -ne 1 ]; then
echo "Usage: $0 <bucket_name>"
exit 1
fi

if ! aws s3api head-bucket --bucket "$BUCKET" 2>/dev/null; then
	echo "Bucket '$BUCKET' does not exist. Exiting."
	exit 1
fi

echo "Bucket '$BUCKET' found. Proceeding with cleanup..."

echo "Removing all versions..."
VERSIONS=$(aws s3api list-object-versions --bucket $BUCKET --query '{Objects: Versions[].{Key:Key,VersionId:VersionId}}' --output json)

if [ "$(echo "$VERSIONS" | jq length)" -gt 0 ]; then
	aws s3api delete-objects --bucket "$BUCKET" \
		--delete "{\"Objects\": $VERSIONS}"
else
	echo "No object versions found."
fi

echo "Deleting delete markers..."
DELETES=$(aws s3api list-object-versions --bucket $BUCKET --query '{Objects: DeleteMarkers[].{Key:Key,VersionId:VersionId}}' --output json)

if [ "$(echo "$DELETES" | jq length)" -gt 0 ]; then
	aws s3api delete-objects --bucket "$BUCKET" \
		--delete "{\"Objects\": $DELETES}"
else
	echo "No delete markers found."
fi

echo " Deleting bucket '$BUCKET'..."
aws s3api delete-bucket --bucket "$BUCKET"

echo "Bucket '$BUCKET' and all its contents have been deleted."
