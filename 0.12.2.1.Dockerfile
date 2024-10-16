FROM python:3.12-bookworm AS build_openssl

ENV OPENSSL_VERSION=1.0.2
ENV OPENSSL_VERSION_MINOR=1.0.2u

WORKDIR /src

ADD https://openssl.org/source/old/${OPENSSL_VERSION}/openssl-${OPENSSL_VERSION_MINOR}.tar.gz openssl.tar.gz

RUN tar xzvf openssl.tar.gz && \
    cd openssl-${OPENSSL_VERSION_MINOR} && \
    ./config && \
    make && \
    make install

# -----------------------------------------------------------------------------
FROM python:3.12-bookworm AS build_wkhtmltopdf

ENV WKHTMLTOPDF_VERSION=0.12.2.1
ENV QT_COMMIT=48e71c19c7fc67517fb3dca6d42eacb57341c9ba

ENV OPENSSL_PATH="/usr/local/ssl"
# Use an old version of C++ standard and include the openssl libs from build_openssl
ENV QMAKE_CXXFLAGS="-std=gnu++98 -I${OPENSSL_PATH}/include"
# Link openssl statically
ENV QMAKE_LFLAGS="-static-libgcc -L${OPENSSL_PATH}/lib"

WORKDIR /src

ADD https://github.com/wkhtmltopdf/wkhtmltopdf/archive/refs/tags/${WKHTMLTOPDF_VERSION}.tar.gz wkhtmltopdf.tar.gz
ADD https://github.com/wkhtmltopdf/qt/archive/${QT_COMMIT}.zip qt.zip

COPY patches-${WKHTMLTOPDF_VERSION} ./patches-${WKHTMLTOPDF_VERSION}

RUN tar xzvf wkhtmltopdf.tar.gz && \
    unzip qt.zip && \
    rm -rf wkhtmltopdf-${WKHTMLTOPDF_VERSION}/qt && \
    mv qt-${QT_COMMIT} wkhtmltopdf-${WKHTMLTOPDF_VERSION}/qt  && \
    find patches-${WKHTMLTOPDF_VERSION} -type f -name '*.patch' -print0 | xargs -t -n 1 -0 patch -p0 -i

COPY --from=build_openssl ${OPENSSL_PATH} ${OPENSSL_PATH}

RUN cd wkhtmltopdf-${WKHTMLTOPDF_VERSION}/ && \
    scripts/build.py posix-local

RUN bash -c "cp -v wkhtmltopdf-${WKHTMLTOPDF_VERSION}/static-build/wkhtmltox-${WKHTMLTOPDF_VERSION}_local-*.tar.xz /wkhtmltox-${WKHTMLTOPDF_VERSION}.tar.xz"
