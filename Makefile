# Variables
ROOT=$(shell pwd)

## Lint
DOCKER_IMAGE_LINTER=alvarofpp/linter:latest
LINT_COMMIT_TARGET_BRANCH=origin/main

# Commands
.PHONY: install-hooks
install-hooks:
	git config core.hooksPath .githooks

.PHONY: lint
lint: install-hooks
	@docker pull ${DOCKER_IMAGE_LINTER}
	@docker run --rm -v ${ROOT}:/app ${DOCKER_IMAGE_LINTER} " \
		lint-commit ${LINT_COMMIT_TARGET_BRANCH} \
		&& lint-markdown \
		&& lint-yaml \
		&& lint-shell-script"
