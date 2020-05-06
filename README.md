# DynoDocker-CR

A prototype framework for templating Dockerfiles with the ability to stamp fixed values, include external files, and render the template as needed.

Usage: dynodocker [arguments]

"-init", "--init", "Initialize settings and template."

"-c", "--console", "Output to console only"

"-o OUTPUT", "--to=OUTPUT", "Specifies file to write output to."

"-h", "--help", "dynodocker help"

## Requirements

To build: Crystal compiler

### Important Files

``` src/dynodocker.cr ``` : main applicaition

```Dockerfile.erb``` : main Dockerfile template

```settings.yml``` : place to assign static values outside of the template
