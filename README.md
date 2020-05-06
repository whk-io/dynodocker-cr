# DynoDocker-CR

A prototype framework for templating Dockerfiles with the ability to stamp fixed values, include external files, and render the template as needed.

## Requirements

To build: Crystal compiler

### Important Files

``` src/dynodocker.cr ``` : main applicaition

```Dockerfile.erb``` : main Dockerfile template

```settings.yml``` : place to assign static values outside of the template
