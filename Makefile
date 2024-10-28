ARTIFACT_ID=k8s-promtail
MAKEFILES_VERSION=9.3.2
VERSION=2.9.1-6

.DEFAULT_GOAL:=help

ADDITIONAL_CLEAN=clean_charts
clean_charts:
	rm -rf ${K8S_HELM_RESSOURCES}/charts

include build/make/variables.mk
include build/make/clean.mk
include build/make/self-update.mk

##@ Release

include build/make/k8s-component.mk

.PHONY: promtail-release
promtail-release: ## Interactively starts the release workflow for promtail
	@echo "Starting git flow release..."
	@build/make/release.sh promtail
