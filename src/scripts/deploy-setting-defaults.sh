#!/bin/bash
echo "export AWS_DEFAULT_REGION=$(echo ${ORB_PARAM_AWS_DEFAULT_REGION:-us-east-1})" >> $BASH_ENV
echo "export AWS_INSTANCE_TYPE=$(echo ${ORB_PARAM_AWS_INSTANCE_TYPE:-t2.micro})" >> $BASH_ENV
echo "export RESOURCE_CLASS=$(echo ${ORB_PARAM_RESOURCE_CLASS})" >> $BASH_ENV
echo "export NUMBER_OF_RUNNERS=$(echo ${ORB_PARAM_NUMBER_OF_RUNNERS:-1})" >> $BASH_ENV
echo "export NUMBER_OF_WAITS=$(echo ${ORB_PARAM_NUMBER_OF_WAITS:-18})" >> $BASH_ENV
echo "export ANSIBLE_FORCE_COLOR=$(echo ${ANSIBLE_FORCE_COLOR:-true})" >> $BASH_ENV
echo "export ANSIBLE_GIT_URL=$(echo ${ANSIBLE_GIT_URL:-https://github.com/CircleCI-Public/on-demand-runner-orb.git})" >> $BASH_ENV
echo "export ANSIBLE_GIT_BRANCH=$(echo ${ANSIBLE_GIT_BRANCH:-main})" >> $BASH_ENV
echo "export ANSIBLE_HOST_KEY_CHECKING=$(echo ${ANSIBLE_HOST_KEY_CHECKING:-false})" >> $BASH_ENV
echo "export RESOURCE_CLASS_CREATION=$(echo ${RESOURCE_CLASS_CREATION:-true})" >> $BASH_ENV
echo "export RUNNER_TOKEN_CREATION=$(echo ${RUNNER_TOKEN_CREATION:-true})" >> $BASH_ENV
echo "export TEMPLATE_DYNAMIC_INVENTORY=$(echo ${TEMPLATE_DYNAMIC_INVENTORY:-true})" >> $BASH_ENV
echo "export CLOUD_PROVIDER=$(echo ${CLOUD_PROVIDER:-aws})" >> $BASH_ENV
echo "export CIRCLECI_USER=$(echo ${ORB_PARAM_CIRCLECI_USER:-circleci})" >> $BASH_ENV