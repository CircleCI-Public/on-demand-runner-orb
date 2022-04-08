# On Demand Runner

[![CircleCI Build Status](https://circleci.com/gh/CircleCI-Public/on-demand-runner-orb.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/CircleCI-Public/on-demand-runner-orb) [![CircleCI Orb Version](https://badges.circleci.com/orbs/cci-labs/on-demand-runner.svg)](https://circleci.com/orbs/registry/orb/cci-labs/on-demand-runner) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/CircleCI-Public/on-demand-runner-orb/main/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)


A orb that lets users spin up runners on the demand durning a pipeline. Users are able to provision an EC2 instance on the fly, install the runner agent, and allow the runner to accept units of work. 

**Please note this orb is part of CircleCI Labs**. CircleCI Labs is a place where unsupported apps and personal project maintained by CircleCI developers can be published! 
You will find some pretty amazing solutions under CircleCI labs, but please keep in mind CircleCI takes no responsibility for your use of these solutions. 

[CircleCI Orb Registry Page](https://circleci.com/orbs/registry/orb/cci-labs/on-demand-runner)

## Why On Demand Runner?

On Demand Runner grew from the need to not have "pet" servers that people had to manage. Having a server sitting in the cloud with the runner agent install just waiting for a job costs money. Furthermore, you have
to make sure your server stays up to date and patched. Now multiple that responsibility by X, where X is the number of runners you need. 

Why not have a model where you only have a server with runner agent installed when you **need** it? Hence On Demand Runner was born! 

On Demand Runner will spin up a fresh EC2 instance for you when you have a pipeline that requires a runner. No longer do you need to pay for an idle server that you have to keep patched. On Demand Runner
allow you to escape the "pet" server and lets you move to having "cattle". 


## How to utilize On Demand Runner!

On Demand Runner could not be more simple to use! On Demand Runner utilizes CircleCI's Orb system to make the end user experience as easy as possible. Here is a little example of how one could use On Demand Runner:

```yaml
  version: 2.1

  orbs:
    on-demand-runner: cci-labs/on-demand-runner@1.0.0

  jobs:
    run-test-on-runner:
      machine: true
      resource_class: NAMESPACE/<< pipeline.id >>
      steps:
        - run: echo "Hello World! I am running on a On Demand Runner!"

  workflows:
    example-workflow:
      jobs:
        - on-demand-runner/deploy:
            resource_class: << pipeline.id >>
            context: aws-creds
        - run-test-on-runner:
            requires:
              - on-demand-runner/deploy
        - on-demand-runner/destroy:
            resource_class: << pipeline.id >>
            context: aws-creds
            requires:
              - "run-test-on-runner"

```

The first step in the pipeline calls the On Demand Runner's orb. Calling `deploy` will deploy an EC2 instance and install runner on that instance. After running the `deploy` job, you are now ready to utilize
the runner which you just deployed. After doing whatever job(s) you need to do on the runner, you can call `destroy`. This job will deprovision the runner you spun up using the `deploy` job. 

Once `destroy` is called the EC2 instance will be terminated and all runner related pieces(resource class and runner token), will be deleted as well. Thus leaving you with a clean slate! 

To see what environment variables you need to set in order for On Demand Runner to work, please refer to the [jobs](https://circleci.com/developer/orbs/orb/cci-labs/on-demand-runner#jobs) section on the orb registry. 


## Tips and Tricks

Here are some tips and tricks to make working with On Demand Runner that much easier!

1. Utilize CircleCI's contexts to set the needed environment variables. It is recommended to use at least an AWS context to store command AWS credentials/secrets. In the both example, `aws-creds` stores all the needed credentials for spinning up an EC2 instance on AWS.

2. Utilize CircleCI's project environment variables to set the specific values for On Demand Runner like `AWS_INSTANCE_TYPE`, `NUMBER_OF_RUNNERS`, `AWS_AMI_ID`, etc. These values will changed from project to project to best suit your needs.

3. If you need more than one On Demand Runner, you can change `NUMBER_OF_RUNNERS` to be whatever you want. For example, you might have a need for 5 runners so setting `NUMBER_OF_RUNNERS` to 5 will spin up 5 EC2 instance configured under the same resource class. 

4. Use a **UNIQUE** resource class name, like `pipeline.id`. This is because when you call `destroy` it will delete all runner tokens associated for the given resource class and then finally delete the resource class. This might cause issues with you utilize a resource class 
name that is in use already. 

5. Upload the SSH key you will be utilizing to the CircleCI project with no `hostname` defined. This will allow Ansible to ssh into the EC2 instance it spun up. If you do not upload the SSH key to CircleCI you will run into a connection error. Please note, the SSH key you upload
to CircleCI should match the one you set in `AWS_SSH_KEY`.
