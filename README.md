# GitLab Terraform Shared State Sample Project

This project is an example on how to use [GitLab's "Managed Terraform State" feature](https://docs.gitlab.com/ee/user/infrastructure/terraform_state.html).

## Basics

Due to personal preferences, I use Docker, docker-compose and Makefiles to execute Terraform files. Docker allows to have an equal execution environment on every machine that executes the code and docker-compose enables mounting the local file system to the Docker container without any hassle.

The Makefile includes all the commands that are needed and allows for sufficient configuration to execute the multiple environments etc.
