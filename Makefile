ARTIFACT_ID=k8s-promtail
MAKEFILES_VERSION=8.8.0
VERSION=2.9.1-1

.DEFAULT_GOAL:=help

ADDITIONAL_CLEAN=clean_charts
clean_charts:
	rm -rf ${K8S_HELM_RESSOURCES}/charts

include build/make/variables.mk
include build/make/clean.mk
include build/make/self-update.mk

##@ Release

K8S_PRE_GENERATE_TARGETS=generate-release-resource
include build/make/k8s-component.mk

.PHONY: generate-release-resource
generate-release-resource: $(K8S_RESOURCE_TEMP_FOLDER)
	@cp manifests/promtail.yaml ${K8S_RESOURCE_TEMP_YAML}

.PHONY: promtail-release
promtail-release: ## Interactively starts the release workflow for promtail
	@echo "Starting git flow release..."
	@build/make/release.sh promtail

##@ Helm dev targets
# Promtail needs a copy of the targets from k8s.mk without image-import because we use an external image here.

.PHONY: ${K8S_HELM_RESSOURCES}/charts
${K8S_HELM_RESSOURCES}/charts: ${BINARY_HELM}
	@cd ${K8S_HELM_RESSOURCES} && ${BINARY_HELM} repo add grafana https://grafana.github.io/helm-charts && ${BINARY_HELM} dependency build

.PHONY: helm-promtail-apply
helm-promtail-apply: ${BINARY_HELM} ${K8S_HELM_RESSOURCES}/charts helm-generate $(K8S_POST_GENERATE_TARGETS) ## Generates and installs the helm chart.
	@echo "Apply generated helm chart"
	@${BINARY_HELM} upgrade -i ${ARTIFACT_ID} ${K8S_HELM_TARGET} --namespace ${NAMESPACE}

.PHONY: helm-promtail-reinstall
helm-promtail-reinstall: helm-delete helm-promtail-apply ## Uninstalls the current helm chart and reinstalls it.

.PHONY: helm-promtail-chart-import
helm-promtail-chart-import: ${BINARY_HELM} ${K8S_HELM_RESSOURCES}/charts k8s-generate helm-generate-chart helm-package-release ## Pushes the helm chart to the k3ces registry.
	@echo "Import ${K8S_HELM_RELEASE_TGZ} into K8s cluster ${K3CES_REGISTRY_URL_PREFIX}..."
	@${BINARY_HELM} push ${K8S_HELM_RELEASE_TGZ} oci://${K3CES_REGISTRY_URL_PREFIX}/k8s ${BINARY_HELM_ADDITIONAL_PUSH_ARGS}
	@echo "Done."