# Terraform

This is an example configuration for some AWS resources to demonstrate the AWeSomeness of Terraform.  It will create a VPC, an application load balancer (ALB), and a few EC2 in multiple AZs running an nginx docker image, and will spin up in just a few minutes.

## !!!WARNINGS!!!
WARNING: THIS WILL COST MONEY!!!

WARNING: DO NOT EDIT RESOURCES CREATED BY TERRAFORM MANUALLY IN AWS ONCE YOU HAVE APPLIED A TERRAFORM PLAN!!! If the resources become out of sync with the state, it can be difficult to recover, which could result in resources not being created, updated, or destroyed in the way that you think they should be.   

## Folder structure

This repo is organized into two parts - modules and live infrastructure. 

### Modules

To DRY up the configuration, some code has been extracted into modules.  Where possible, utilize modules to build infrastructure.

### Live 

There are four high levels of organization:  global resources, production, staging, and state resources.

#### Production, Staging

Exactly what it sounds like.  Each environment is broken up into region, and for now (while our infrastructure is small-ish), we can organize by utilizing one state file per combination of environment and region.

#### Global

Some resources are global and therefore shared by multiple environments.  An example of this is the Route 53 hosted zones.  Individual zone records should be kept as closely as possible to the environment to which they're related, but Terraform's remote state feature allows querying on properties without sharing state.

#### State - Chicken or Egg?

Terraform creates resources.  Terraform stores the state of those resources in a backend somewhere.  By default, that backend is local.  What if you want to use an S3 bucket as a backend?  Great!  Well, except, Terraform won't create that backend for you automatically.  This makes sense, for a few reasons: 
* Terraform needs to read from a state file to know what resources are available.  If that state doesn't already exist, it can't read from it to tell whether or not it exists.  Bummer.
* Terraform doesn't do much that you don't tell it to do, which is a really good thing.  Every environment has its own special requirements, and Terraform isn't opinionated enough to guess what you need.

We'll utilize S3 as a backend for storing remote state with DynamoDB as a way to provide state locking, so this level of live infrastructure allows us to create the S3 bucket and DynamoDB table, separate from the resources that will utilize it.  These resources are organized in the same way that the environments are, and they must be created before each state can be utilized.

Possible alternative solutions?

* [Monterail has a potential solution](https://www.monterail.com/blog/chicken-or-egg-terraforms-remote-backend), though I haven't found success with it quite yet.

## Initialization

1. For the love of Baphomet, don't use Windows.  We'll be using wrapper scripts written in bash, so you'll need to be able to run those.  Linux, OSX, or VirtualBox with some Unixy variant so you have access to a terminal.
2. Install Terraform v0.11.8 (requires this version exactly, v0.12.x is not stable and may not work without modification)

### State Resources

The state resources only need to be created once.  The statefiles for these will simply be stored in the repository until we can come up with a better solution.

Since these resources will be kept locally (for now), we don't need to provide a backend configuration for them.

`terraform init`

`terraform plan -out plan`

`terraform apply plan`

These commands may prompt for input, for AWS_PROFILE.  You may enter it when prompted, but to avoid the prompt, you may also supply an additional variable file.  Create `secret.tfvars` (this specifically so it will be ignored in repo), with the contents:
```
AWS_PROFILE = "name_of_your_aws_profile"
```

Then, to the plan command, add a `-var-file=secrets.tfvars` flag, as such:

`terraform plan -var-file=secrets.tfvars -out plan`

### Local Development

## Setup

1. If state resources are not created, do that first.
2. Navigate to an environment/region you'd like to work on (i.e. live/staging/us-west-2)
3. Copy file, `secret.tfvars.example` to `secret.tfvars`
4. Update values in `secret.tfvars` to match your desired configuration
5. Terraform init according to section below
6. Init, then plan, apply, repeat!

## Initializing

Most parameters for the backend are already configured.  However, when running locally, an additional argument of profile must be passed into the backend config that allows you to access the state at AWS.  You can run it as follows:

`terraform init -backend-config="profile=your_aws_profile"`

## Planning

You want to run a plan before you apply any changes.  This will both validate that your configuration has no syntax errors, and it will show you what Terraform believes it needs to create, update, or destroy.  The planning phase requires all of the input variables to be met, so for any secret or environment-specific values, supply the `secret.tfvars` you created as an argument with `var-file` as such:

`terraform plan -var-file=secret.tfvars -out plan`

## Applying

When you develop a plan, the secrets, variables, etc, are all saved directly in the plan.  Therefore, no additional arguments usually need to be applied.

`terraform apply plan`

## AWS Profile

In lieu of using AWS credentials directly, use an AWS profile to avoid the credentials being stored directly in the repository

## Best Practices

* Ensure every resource created by TF has a tag Terraform = true and Environment = ${var.ENVIRONMENT}
* Ensure that any resource you don't want destroyed by a `terraform destroy` command has the `prevent_destroy = true` lifecycle configuration option
* It may be tempting to store versions of the plan files.  However, there's no reason to do so since they rely on specific versions of the state, and are meant to be discarded immediately after they are applied.

## Resources that aren't Terraform'd

* Manged security rules on WAF
* Vendor subscriptions - if AMI is provided under subscription, use the AMI id instead
* Application provisioning - this is what Chef/Ansible/Docker/K8s are for

## Limitations / workarounds

* Terraform backend configuration cannot contain interpolation.  Additional parameters to backend configuration may be passed in when running `terraform init` as such:

```
$ terraform init -backend-config="profile=name_of_aws_profile" 
```

See [this link](https://www.terraform.io/docs/backends/config.html#partial-configuration)

## TODO:

* Default set of tags, every resource merges default tags with ones custom