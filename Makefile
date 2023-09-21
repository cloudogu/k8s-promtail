# Set these to the desired values
ARTIFACT_ID=k8s-promtail
MAKEFILES_VERSION=8.3.0
VERSION=2.9.1-1

.DEFAULT_GOAL:=help

include build/make/variables.mk
include build/make/clean.mk
include build/make/self-update.mk

K8S_PRE_GENERATE_TARGETS=generate-release-resource
include build/make/k8s-component.mk

.PHONY: generate-release-resource
generate-release-resource: $(K8S_RESOURCE_TEMP_FOLDER)
	@cp manifests/promtail.yaml ${K8S_RESOURCE_TEMP_YAML}