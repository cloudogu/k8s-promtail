#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

componentTemplateFile=k8s/helm/component-patch-tpl.yaml
promtailTempChart="/tmp/promtail"
promtailTempValues="${promtailTempChart}/values.yaml"
promtailTempChartYaml="${promtailTempChart}/Chart.yaml"

# this function will be sourced from release.sh and be called from release_functions.sh
update_versions_modify_files() {
  echo "Update helm dependencies"
  make helm-update-dependencies  > /dev/null

  # Extract promtail chart
  local promtailVersion
  promtailVersion=$(yq '.dependencies[] | select(.name=="promtail").version' < "k8s/helm/Chart.yaml")
  local promtailPackage
  promtailPackage="k8s/helm/charts/promtail-${promtailVersion}.tgz"

  echo "Extract promtail helm chart"
  tar -zxvf "${promtailPackage}" -C "/tmp" > /dev/null

  local promtailAppVersion
  promtailAppVersion=$(yq '.appVersion' < "${promtailTempChartYaml}")

  echo "Set images in component patch template"
  setAttributeInComponentPatchTemplate ".values.images.promtail" "grafana/promtail:${promtailAppVersion}"
  update_component_patch_template ".values.images.sidecar" ".sidecar.configReloader.image"

  rm -rf ${promtailTempChart}
}

update_component_patch_template() {
  local componentTemplateKey="${1}"
  local dependencyValuesKey="${2}"

  local repository
  repository=$(yq "${dependencyValuesKey}.repository" < "${promtailTempValues}")
  local tag
  tag=$(yq "${dependencyValuesKey}.tag" < "${promtailTempValues}")

  setAttributeInComponentPatchTemplate "${componentTemplateKey}" "${repository}:${tag}"
}

setAttributeInComponentPatchTemplate() {
  local key="${1}"
  local value="${2}"

  yq -i "${key} = \"${value}\"" "${componentTemplateFile}"
}

update_versions_stage_modified_files() {
  git add "${componentTemplateFile}"
}
