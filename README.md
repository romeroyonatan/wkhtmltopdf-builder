# wkhtmltopdf Builder for Debian

This project provides a set of scripts and instructions to build `wkhtmltopdf`
from source on newer versions of Debian. `wkhtmltopdf` is a command-line tool
that renders HTML into PDF using the Qt WebKit rendering engine.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Building wkhtmltopdf](#building-wkhtmltopdf)

## Features

- Build `wkhtmltopdf` from source on Debian 12 (bookworm)
- `docker` is only required dependency

## Requirements

Before you begin, ensure you have the following installed:

- `docker` for building the repository

## Building wkhtmltopdf

To build `wkhtmltopdf`, run the following command:

```bash
make
```

You can also build an spercific version using
```bash
make VERSION=0.12.2.1
````

This script will:

- Download the latest version of `wkhtmltopdf`, `openssl` and `qt`
- Compile the source code.
- Create a tarball with the artifacts in `dist/`
