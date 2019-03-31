#!/bin/bash

# specify input parameters
environment=DEV
awsConfigProfileName=DEV

subnetId1=subnet-01d3cf56c3391b8f5
subnetId2=subnet-01d3cf56c3391b8f5
securityGroupId=sg-0218decf8ff3c408a
apiDeployStageName=dev

s3BucketForArtifacts=capdev-deployment
s3FolderPrefixForArtifacts=ccs-pipeline

RELEASE_VERSION_NUMBER=1.0

echo ""
echo "Using AWS Config Profile: $awsConfigProfileName"
echo ""

#-------------------------------------------------------------------------------------------------
# Update template file with local lambda file names (full path)
#-------------------------------------------------------------------------------------------------
cp  ./sam-cicd-demo-lambdas.yml  ./sam-cicd-demo-lambdas-pre-packaged.yml
sed -i -e "s/\[RELEASE_VERSION_NUMBER\]/$RELEASE_VERSION_NUMBER/g" ./sam-cicd-demo-lambdas-pre-packaged.yml

echo ""
echo "Created ./sam-cicd-demo-lambdas-pre-packaged.yml file with lambda local file names"
echo "Trying to upload modified lambda files to S3..." 
echo ""
echo ""

#-------------------------------------------------------------------------------------------------
# Package: Upload the modifies files to S3 and update the template with S3 path
#-------------------------------------------------------------------------------------------------
aws.exe cloudformation package \
	--template-file ./sam-cicd-demo-lambdas-pre-packaged.yml \
	--s3-bucket $s3BucketForArtifacts \
	--s3-prefix $s3FolderPrefixForArtifacts \
	--output-template-file ./sam-cicd-demo-lambdas-packaged.yml	

echo ""
echo "Upload of lambda files to S3 complete"
echo ""





