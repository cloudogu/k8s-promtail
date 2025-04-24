# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [v2.9.1-8] - 2025-04-24
### Changed
- [#16] Set sensible resource limits and requests

## [v2.9.1-7] - 2024-12-10
### Added
- [#14] NetworkPolicy to block all ingress traffic
- [#14] Ingress Network Policy for Loki-gateway so that Promtail can access it

## [v2.9.1-6] - 2024-10-28
### Changed
- [#12] Use `ces-container-registries` secret for pulling container images as default.

## [v2.9.1-5] - 2024-10-08
### Fixed
- [#8] Fix helm version constraint for dependency k8s-loki

## [v2.9.1-4] - 2024-10-07

### Attention
- This release is broken due to an invalid helm dependency constraint for `k8s-loki`. Please use the next release.

### Changed
- [#8] Remove ansi color codes from log output.

### Fixed
- Fixed helm version constraint and allow loki versions >=2.9.1-0 and <4.0.0-0

## [v2.9.1-3] - 2024-09-19
### Changed
- Relicense to AGPL-3.0-only

## [v2.9.1-2] - 2023-12-07
### Added
- [#2] Add patch templates to use this chart in airgapped environments.
- [#4] Add default configuration for using k8s-loki

## [v2.9.1-1] - 2023-09-26
### Added
- Set up initial resources for k8s-promtail 2.9.1
