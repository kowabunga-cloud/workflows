# About

This is a collection of shared GitHub Action workflows.

[![License: Apache License, Version 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://spdx.org/licenses/Apache-2.0.html)
[![time tracker](https://wakatime.com/badge/github/kowabunga-cloud/workflows.svg)](https://wakatime.com/badge/github/kowabunga-cloud/workflows)
![Code lines](https://sloc.xyz/github/kowabunga-cloud/workflows/?category=code)
![Comments](https://sloc.xyz/github/kowabunga-cloud/workflows/?category=comments)
![COCOMO](https://sloc.xyz/github/kowabunga-cloud/workflows/?category=cocomo&avg-wage=100000)

## Development Guidelines

Development relies on [pre-commit hooks](http://www.pre-commit.com/) to ensure proper commits.

Follow installation instructions [here](https://pre-commit.com/#install).

Local per-repository installation can be done through:

```sh
$ pre-commit install --install-hooks
```

And system-wide global installation, through:

```sh
$ git config --global init.templateDir ~/.git-template
$ pre-commit init-templatedir ~/.git-template
```

Development relies on [Semantic Versioning](https://semver.org/) and unscoped [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) for development.

Changelog is automatically triggered from commits summary from the following commits types: **feat**, **fix**, **perf**, **chore**, **docs**, e.g.

```
feat!: upgrade API version         <- will increase version major number at release
feat: add new super nice feature   <- will increase version minor number at release
fix: correct bug XYZ               <- will increase version patch number at release
```

## Versioning

Versioning generally follows [Semantic Versioning](https://semver.org/).

## Authors

workflows are maintained by [Kowabunga maintainers](https://github.com/orgs/kowabunga-cloud/teams/maintainers).

## License

Licensed under [Apache License, Version 2.0](https://opensource.org/license/apache-2-0), see [`LICENSE`](LICENSE).
