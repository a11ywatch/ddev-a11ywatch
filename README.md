[![tests](https://github.com/a11ywatch/ddev-a11ywatch/actions/workflows/tests.yml/badge.svg)](https://github.com/a11ywatch/ddev-a11ywatch/actions/workflows/tests.yml) ![project is maintained](https://img.shields.io/maintenance/yes/2024.svg)

## What is this?

This repository allows you to quickly install the warp speed accessibility and vast coverage tool [A11yWatch Lite](https://github.com/a11ywatch/a11ywatch) into a [Ddev](https://ddev.readthedocs.io) project using just `ddev get drud/ddev-a11ywatch`.

## Installation

1. `ddev get drud/ddev-a11ywatch && ddev restart`
2. `ddev restart`

## Explanation

This A11yWatch recipe for [ddev](https://ddev.readthedocs.io) installs a [`.ddev/docker-compose.a11ywatch-standalone.yaml`](docker-compose.a11ywatch-standalone.yaml) using the [`A11yWatch`](https://hub.docker.com/r/a11ywatch/a11ywatch/tags) stand-alone docker image.

## Interacting with A11yWatch

* The A11ywatch instance will listen on TCP port 3280 (the A11yWatch default) and port 50050 for gRPC.
* Configure your application to access A11ywatch on the host:port `a11ywatch:3280`.

## Additional Resources

* To get detailed infromation on how to interact or commincate with the [A11yWatch API Info](https://a11ywatch.com/api-info) A11yWatch.
* The [A11yWatch CLI](https://github.com/a11ywatch/a11ywatch) is helpful to perform automated task using the gRPC client.

## Todo

1. Add web panel option start using the `a11ywatch/web` image.

**Contributed by [j-mendez](https://github.com/j-mendez)**
