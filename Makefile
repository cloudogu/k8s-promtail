# Set these to the desired values
ARTIFACT_ID=k8s-promtail
MAKEFILES_VERSION=8.3.0
VERSION=2.9.1-1

.DEFAULT_GOAL:=help

include build/make/variables.mk
include build/make/clean.mk
include build/make/digital-signature.mk
include build/make/release.mk
include build/make/bats.mk
