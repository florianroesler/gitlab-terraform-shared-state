environment=$(*)
service_name = "terraform_infrastructure"
base_directory="/app"
var_file = "$(base_directory)/secret.tfvars"
gitlab_url = "https://gitlab.com/api/v4/projects/$(GITLAB_PROJECT_ID)/terraform/state/$(environment)"

include gitlab.env

gitlab_parameters = -backend-config="address=$(gitlab_url)" \
										-backend-config="lock_address=$(gitlab_url)/lock" \
										-backend-config="unlock_address=$(gitlab_url)/lock" \
										-backend-config="username=$(GITLAB_USER_NAME)" \
										-backend-config="password=$(GITLAB_ACCESS_TOKEN)" \
										-backend-config="lock_method=POST" \
										-backend-config="unlock_method=DELETE" \
										-backend-config="retry_wait_min=5"

init-%:
	docker-compose run $(service_name) -chdir=$(base_directory)/$(environment) init $(gitlab_parameters)

providers-%:
	docker-compose run $(service_name) -chdir=$(base_directory)/$(environment) providers

plan-%:
	docker-compose run $(service_name) -chdir=$(base_directory)/$(environment) plan -var-file=$(var_file)

apply-%:
	docker-compose run $(service_name) -chdir=$(base_directory)/$(environment) apply -var-file=$(var_file)
