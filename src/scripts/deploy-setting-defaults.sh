#!/bin/bash
{
    echo "export AWS_DEFAULT_REGION=$(echo ${ORB_PARAM_AWS_DEFAULT_REGION:-us-east-1})"
    echo "export AWS_INSTANCE_TYPE=$(echo ${ORB_PARAM_AWS_INSTANCE_TYPE:-t2.micro})"
    echo "export RESOURCE_CLASS=$(echo ${ORB_PARAM_RESOURCE_CLASS})"
    echo "export NUMBER_OF_RUNNERS=$(echo ${ORB_PARAM_NUMBER_OF_RUNNERS:-1})"
    echo "export NUMBER_OF_WAITS=$(echo ${ORB_PARAM_NUMBER_OF_WAITS:-18})"
    echo "export ANSIBLE_FORCE_COLOR=$(echo ${ANSIBLE_FORCE_COLOR:-true})"
    echo "export ANSIBLE_GIT_URL=$(echo ${ANSIBLE_GIT_URL:-https://github.com/CircleCI-Public/on-demand-runner-orb.git})"
    echo "export ANSIBLE_GIT_BRANCH=$(echo ${ANSIBLE_GIT_BRANCH:-main})"
    echo "export ANSIBLE_HOST_KEY_CHECKING=$(echo ${ANSIBLE_HOST_KEY_CHECKING:-false})"
    echo "export RESOURCE_CLASS_CREATION=$(echo ${RESOURCE_CLASS_CREATION:-true})"
    echo "export RUNNER_TOKEN_CREATION=$(echo ${RUNNER_TOKEN_CREATION:-true})"
    echo "export TEMPLATE_DYNAMIC_INVENTORY=$(echo ${TEMPLATE_DYNAMIC_INVENTORY:-true})"
    echo "export CLOUD_PROVIDER=$(echo ${CLOUD_PROVIDER:-aws})"
    echo "export CIRCLECI_USER=$(echo ${ORB_PARAM_CIRCLECI_USER:-circleci})"
} >> $BASH_ENV