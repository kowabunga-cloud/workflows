# About

This is a collection of shared GitHub Action workflows.

[![License: Apache License, Version 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://spdx.org/licenses/Apache-2.0.html)
[![time tracker](https://wakatime.com/badge/github/kowabunga-cloud/workflows.svg)](https://wakatime.com/badge/github/kowabunga-cloud/workflows)
![Code lines](https://sloc.xyz/github/kowabunga-cloud/workflows/?category=code)
![Comments](https://sloc.xyz/github/kowabunga-cloud/workflows/?category=comments)
![COCOMO](https://sloc.xyz/github/kowabunga-cloud/workflows/?category=cocomo&avg-wage=100000)

## Reusable Workflows

| Workflow | Purpose |
|----------|---------|
| [`commitlint.yml`](.github/workflows/commitlint.yml) | Validates pushed commits and pull requests (commits and title) against Conventional Commits. |
| [`release.yml`](.github/workflows/release.yml) | Semantic release (version, changelog, tag and GitHub release) out of Conventional Commits, without building anything. Tag-triggered publishing workflows get triggered by the pushed tag. |
| [`go-ci.yml`](.github/workflows/go-ci.yml) | Go code review, linter, multi-arch builds (Ubuntu 24.04 and 26.04) and unit tests (optionally with a MongoDB server, `mongodb: true`, exposed as `TEST_MONGODB_URI`). |
| [`go-sec.yml`](.github/workflows/go-sec.yml) | Go security checks (gosec). |
| [`go-vuln.yml`](.github/workflows/go-vuln.yml) | Go vulnerabilities checks (govulncheck). |
| [`go-release.yml`](.github/workflows/go-release.yml) | Semantic release, then Ubuntu 24.04 (noble) Debian packages build and APT repository publishing. |
| [`openapi-release.yml`](.github/workflows/openapi-release.yml) | Semantic release of the OpenAPI specification. |

Go workflows use the latest patch release of the Go version declared in `go.mod`.

Release workflows share the [`semantic-release`](.github/actions/semantic-release/action.yml) composite action, which pins the whole semantic-release toolchain. They require the `KOWABUNGA_BOT_APP_ID` variable and `KOWABUNGA_BOT_PRIVATE_KEY` secret (GitHub App), so that release commits and tags can be pushed, and trigger tag-based workflows.

Typical usage, releasing on every push to the main branch:

```yaml
name: Release

on:
  push:
    branches:
      - master
  workflow_dispatch:

permissions:
  contents: write
  issues: write
  pull-requests: write

jobs:
  release:
    uses: kowabunga-cloud/workflows/.github/workflows/release.yml@v1
    secrets: inherit
```

[`templates/`](templates/) holds the reference semantic-release (`.releaserc.json`) and Dependabot configurations.

## Development Guidelines

Development relies on [pre-commit hooks](http://www.pre-commit.com/) to ensure proper commits.

Follow installation instructions [here](https://pre-commit.com/#install).

Local per-repository installation (including the commit message hook) can be done through:

```sh
$ pre-commit install --install-hooks
```

And system-wide global installation, through:

```sh
$ git config --global init.templateDir ~/.git-template
$ pre-commit init-templatedir -t pre-commit -t commit-msg ~/.git-template
```

Development relies on [Semantic Versioning](https://semver.org/) and [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) (unscoped, except for dependencies updates, e.g. `chore(deps):`).

Releases and changelogs are automatically generated from commits, on every push to the main branch:

```
feat!: upgrade API version              <- major release (breaking change)
feat: add new super nice feature        <- minor release
fix: correct bug XYZ                    <- patch release
perf: speed up XYZ                      <- patch release
chore(deps): update dependencies        <- patch release
chore: / ci: / build: / docs: / test: / refactor: / style:   <- no release
```

## Versioning

Projects reference these workflows through major version tags (e.g. `@v1`), which are moved forward on each compatible release of this repository:

```sh
$ git tag v1.x.y && git tag -f v1 && git push origin v1.x.y && git push -f origin v1
```

## Authors

workflows are maintained by [Kowabunga maintainers](https://github.com/orgs/kowabunga-cloud/teams/maintainers).

## License

Licensed under [Apache License, Version 2.0](https://opensource.org/license/apache-2-0), see [`LICENSE`](LICENSE).
