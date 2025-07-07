FROM python:3.12-bookworm AS build_openssl

ENV OPENSSL_VERSION=1.0.2
ENV OPENSSL_VERSION_MINOR=1.0.2u
ENV CFLAGS="-fPIC"

WORKDIR /src

ADD https://openssl.org/source/old/${OPENSSL_VERSION}/openssl-${OPENSSL_VERSION_MINOR}.tar.gz openssl.tar.gz

RUN tar xzvf openssl.tar.gz && \
    cd openssl-${OPENSSL_VERSION_MINOR} && \
    ./config && \
    make && \
    make install

# -----------------------------------------------------------------------------
FROM python:3.12-bookworm AS build_wkhtmltopdf

ENV WKHTMLTOPDF_VERSION=0.12.5
ENV QT_COMMIT=5db36ec76b29712eb2c5bd0625c2c77d7468b3fc

ENV OPENSSL_PATH="/opt/openssl"
ENV QT_PATH="/opt/qt"
ENV WKHTMLTOPDF_PATH="/opt/wkhtmltopdf"

ENV OPENSSL_LIBS="-L${OPENSSL_PATH}/lib"
ENV QMAKESPEC="/src/wkhtmltopdf-${WKHTMLTOPDF_VERSION}/qt/mkspecs/linux-g++/"

# Use an old version of C++ standard and include the openssl libs
ENV QMAKE_CXXFLAGS="-std=gnu++98 -I${OPENSSL_PATH}/include"

WORKDIR /src

ADD https://github.com/wkhtmltopdf/wkhtmltopdf/archive/refs/tags/${WKHTMLTOPDF_VERSION}.tar.gz wkhtmltopdf.tar.gz
ADD https://github.com/wkhtmltopdf/qt/archive/${QT_COMMIT}.zip qt.zip

COPY patches patches/

RUN tar xzvf wkhtmltopdf.tar.gz && \
    unzip qt.zip && \
    rm -rf wkhtmltopdf-${WKHTMLTOPDF_VERSION}/qt && \
    mv qt-${QT_COMMIT} wkhtmltopdf-${WKHTMLTOPDF_VERSION}/qt  && \
    find patches -type f -name '*.patch' -print0 -exec patch -p0 -i {} \;

COPY --from=build_openssl /usr/local/ssl ${OPENSSL_PATH}
COPY Makefile .

RUN make

# -------------------------------------------------------------------------------
FROM scratch AS release

ARG TARGETOS
ARG TARGETARCH

ENV WKHTMLTOPDF_VERSION=0.12.5

COPY --from=build_wkhtmltopdf /opt/wkhtmltopdf/bin/wkhtmltopdf /wkhtmltopdf-v${WKHTMLTOPDF_VERSION}-${TARGETOS}-${TARGETARCH}
