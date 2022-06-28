.DEFAULT_GOAL:=help
SHELL:=/bin/bash

.PHONY: build
build: ## Package up the lambda
	mkdir -p template/webpage/assets/
	( cd src/ && yarn install )
	( cd src/ && zip -r ../template/webpage/assets/lambda.zip . )

.PHONY: deploy destroy
deploy: ## Deploy the infrastructure
	terraform -chdir=template/webpage init
	terraform -chdir=template/webpage apply -auto-approve
	terraform -chdir=template/webpage output

destroy: ## Destroy the infrastructure
	terraform -chdir=template/webpage destroy -auto-approve

.PHONY: sso aws-check
sso: ## Configure AWS SSO
	aws configure sso --profile default

aws-check: ## Check that AWS is configured correctly
	aws sts get-caller-identity

.PHONY: help
help: ## Display this help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
