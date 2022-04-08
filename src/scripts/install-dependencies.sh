#!/bin/bash
pip install "ansible==${ORB_PARAM_ANSIBLE_VERSION}"
pip install boto3 botocore --upgrade
ansible-galaxy collection install amazon.aws community.general