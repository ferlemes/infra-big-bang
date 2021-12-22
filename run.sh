#!/bin/bash

if [ -z "${AWS_ACCESS_KEY_ID}" ]; then
  echo "What is your AWS_ACCESS_KEY_ID? "
  read AWS_ACCESS_KEY_ID
  export AWS_ACCESS_KEY_ID
fi

if [ -z "${AWS_SECRET_ACCESS_KEY}" ]; then
  echo "What is your AWS_SECRET_ACCESS_KEY? "
  read AWS_SECRET_ACCESS_KEY
  export AWS_SECRET_ACCESS_KEY
fi

export AWS_DEFAULT_REGION=us-east-1

cd /terraform

terraform init
[ $? -ne 0 ] && exit 1

terraform plan -out plan.js

echo "Do you wish to proceed with apply? (Yes/No)"
read answer
answer=`echo ${answer} | tr '[A-Z]' '[a-z]'`

if [ "${answer}" == "yes" ]; then

  terraform apply plan.js

  echo -e "Please check your infrastructure.\n"
  echo "If there is any problem and you want to destroy the resources, please type 'destroy'. "
  read answer
  answer=`echo ${answer} | tr '[A-Z]' '[a-z]'`
  if [ "${answer}" == "destroy" ]; then
    echo "Ok, destroying resources."
    terraform destroy
  else
    echo "Ok. Keeping resources. Bye!"
  fi

else
  echo "Aborting."
fi
