# GitLab Terraform Shared State Sample Project

This project is an example on how to use [GitLab's "Managed Terraform State" feature](https://docs.gitlab.com/ee/user/infrastructure/terraform_state.html).

## Basics

Due to personal preferences, I use Docker, docker-compose and Makefiles to execute Terraform files. Docker allows to have an equal execution environment on every machine that executes the code and docker-compose enables mounting the local file system to the Docker container without any hassle.

The Makefile includes all the commands that are needed and allows for sufficient configuration to execute the multiple environments etc.

## Preparations

### 1. Setup GitLab

Follow [this guide by GitLab](https://docs.gitlab.com/ee/user/infrastructure/terraform_state.html) on how to setup your project and permissions. Note down the project ID, which you can find at **Settings > General** within your project.

### 2. Create the personal access token

Follow [this guide by Gitlab](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html) on generating your personal access token. Make sure to activate the `api` scope and note down the generated token (preferrably in your password manager of choice).

### 3. Prepare your gitlab.env file

The Makefile in this project is based on environment variables, which are loaded through a `gitlab.env` file, which is excluded from version control through the `.gitignore` file. I have put a `gitlab.env.sample` file in the project, which you can either just rename or copy & rename to `gitlab.env`.

It includes three environment variables: `GITLAB_USER_NAME`, `GITLAB_ACCESS_TOKEN` and `GITLAB_PROJECT_ID`. The user name is simply your email for signing in to GitLab and the other two environment variables can be filled with the information obtained in the previous steps.

### 4. Prepare your secret.tfvars file

Just like with the `gitlab.env` file, I have put a `secret.tfvars.sample` file into the project, which you can simply rename to `secret.tfvars`. The resulting file is again excluded from version control through `.gitignore`.

The `secret.tfvars` file is loaded during `terraform plan` and `terraform apply` steps by the Makefile.

### 5. Fill the project with your code

Now it is your turn to fill the project with your coded infrastructure. I have prepared a `production` folder with a basic `main.tf` file in it (the backend declaration must remain so that Terraform can do its state magic on GitLab).

You can create other environments besides `production`. Just create a folder next to the `production` folder and place a `main.tf` file in it with the same backend declaration.

I will show you how to plan/apply the different environments in the next step.

### 6. Execute your code

As already stated, this project is based on [this central Makefile](https://github.com/florianroesler/gitlab-terraform-shared-state/blob/main/Makefile), which holds all important commands.

If you have Docker and docker-compose installed, you can simply run the commands from it without any modifications. The main commands are `make init-{environment}`, `make plan-{environment}` and `make apply-{environment}`. Replace the `{environment}` placeholder with the environment you want to run the command for, e.g. `make init-production`.

If you want to run the code without docker-compose on your host OS, then simply replace the `docker-compose run $(docker_compose_service_name)` parts in the Makefile with `terraform`.
