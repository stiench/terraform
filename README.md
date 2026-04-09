# Terraform

## Project

This project is used to manage GitHub repositories and, optionally, organization-specific resources.

## Install

In order to use it, you must start by cloning the repository.
Then, you can use the following command to initialize the project :
```bash
terraform init
```

## Config

Config to be added :
```bash
export TF_VAR_github_owner=stiench
export GITHUB_TOKEN=token
```

For personal use, that is enough.

If `TF_VAR_github_owner` is omitted, the provider will use the authenticated user.

## Usage

To see the impacts of the modification you did, use the command :
```bash
terraform plan
```

And to apply them, you the following one :
```bash
terraform apply
```

Import a repository :
```bash
terraform import github_repository.terraform terraform
```

Remove state :
```bash
terraform state rm 'github_branch_protection_v3.mercury-documentation-generator'  
```

## Doc

[https://registry.terraform.io/providers/integrations/github/latest/docs](https://registry.terraform.io/providers/integrations/github/latest/docs)
