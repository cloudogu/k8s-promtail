# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Changed
- [#8] Remove ansi color codes from log output.

### Fixed
- Fixed helm version constraint and allow loki versions >=2.9.1-0

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