FROM python:3.12-bookworm

ENV WKHTMLTOPDF_VERSION=0.12.2.1
ENV QT_VERSION=48e71c19c7fc67517fb3dca6d42eacb57341c9ba
ENV OPENSSL_VERSION=1.0.2
ENV OPENSSL_VERSION_MINOR=1.0.2u

WORKDIR /src

ADD https://github.com/wkhtmltopdf/wkhtmltopdf/archive/refs/tags/${WKHTMLTOPDF_VERSION}.tar.gz wkhtmltopdf.tar.gz
ADD https://github.com/wkhtmltopdf/qt/archive/${QT_VERSION}.zip qt.zip
ADD https://openssl.org/source/old/${OPENSSL_VERSION}/openssl-${OPENSSL_VERSION_MINOR}.tar.gz openssl.tar.gz

RUN tar xzvf wkhtmltopdf.tar.gz && \
    tar xzvf openssl.tar.gz && \
    unzip qt.zip
RUN rm -rf wkhtmltopdf-${WKHTMLTOPDF_VERSION}/qt && \
    mv qt-${QT_VERSION} wkhtmltopdf-${WKHTMLTOPDF_VERSION}/qt  # TODO: Use symlink
RUN cd openssl-${OPENSSL_VERSION_MINOR} && \
    ./config && \
    make && \
    make install

COPY patches-${WKHTMLTOPDF_VERSION} ./patches-${WKHTMLTOPDF_VERSION}
RUN find patches-${WKHTMLTOPDF_VERSION} -type f -name '*.patch' -print0 | xargs -t -n 1 -0 patch -p0 -i
RUN cd wkhtmltopdf-${WKHTMLTOPDF_VERSION}/ && \
    scripts/build.py posix-local

# TODO: Check if is it still required
# qt/src/xmlpatterns/api/qcoloroutput_p.h https://src.fedoraproject.org/rpms/qt/blob/rawhide/f/qt-everywhere-opensource-src-4.8.7-gcc6.patch
