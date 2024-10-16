# wkhtmltopdf Builder for Debian

This project provides a set of scripts and instructions to build `wkhtmltopdf`
from source on newer versions of Debian. `wkhtmltopdf` is a command-line tool
that renders HTML into PDF using the Qt WebKit rendering engine.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Building wkhtmltopdf](#building-wkhtmltopdf)
- [Usage](#usage)
- [Contributing](#contributing)

## Features

- Build `wkhtmltopdf` from source on Debian 12 (bookworm)
- Just `docker` is needed

## Requirements

Before you begin, ensure you have the following installed:

- `docker` for building the repository

## Building wkhtmltopdf

To build `wkhtmltopdf`, run the following command:

```bash
docker build . -f $VERSION.Dockerfile -t wkhtmltopdf
```

This script will:

- Download the latest version of `wkhtmltopdf`, `openssl` and `qt`
- Compile the source code.
- Create a tarball with the artifacts in `/`


## Usage

Once the build is complete, you can extract `wkhtmltopdf` from the container as follows:

```
docker create --name builder wkhtmltopdf
docker cp builder:/wkhtmltopdf-$VERSION.tar.xz .
```

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any bugs or feature requests.

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/YourFeature`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/YourFeature`).
5. Open a pull request.
