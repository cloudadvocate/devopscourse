#!/bin/bash

if [ -z "$AWS_ACCESS_KEY_ID" ]
then
      echo "Environment variable \$AWS_ACCESS_KEY_ID is empty"
      exit 1
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]
then
      echo "Environment variable \$AWS_SECRET_ACCESS_KEY is empty"
      exit 1
fi

if [ -z "$AWS_DEFAULT_REGION" ]
then
      echo "Environment variable \$AWS_DEFAULT_REGION is empty"
      exit 1
fi

packer init book-manager.pkr.hcl
packer build book-manager.pkr.hcl