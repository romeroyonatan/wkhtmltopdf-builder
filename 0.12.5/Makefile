# Makefile to build wkhtmltopdf with its patched Qt

# --- Configuration Variables ---
# Set the wkhtmltopdf version. Can be overridden by passing WKHTMLTOPDF_VERSION=X.Y.Z to make
WKHTMLTOPDF_VERSION ?= 0.12.5 # Default version, change if needed

# Source directories
WKHTMLTOPDF_SRC_DIR := wkhtmltopdf-$(WKHTMLTOPDF_VERSION)
QT_SRC_DIR := $(WKHTMLTOPDF_SRC_DIR)/qt

# Installation directories
# This is where the custom-built Qt will be installed
QT_INSTALL_PREFIX := $(QT_PATH)
# This is the final installation directory for wkhtmltopdf binaries
INSTALL_ROOT := $(WKHTMLTOPDF_PATH)

# --- Phony Targets ---
.PHONY: all qt_configure qt_build qt_install wkhtmltopdf_configure wkhtmltopdf_build install clean

# --- Main Target ---
all: install

# --- Qt Build Targets ---
qt_configure:
	$(MAKE) -C $(QT_SRC_DIR) clean || true
	cd $(QT_SRC_DIR) && \
		./configure \
		-prefix $(QT_INSTALL_PREFIX) \
		-opensource \
		-confirm-license \
		-fast \
		-release \
		-static \
		-graphicssystem raster \
		-webkit \
		-exceptions \
		-xmlpatterns \
		-system-zlib \
		-system-libpng \
		-system-libjpeg \
		-no-libmng \
		-no-libtiff \
		-no-accessibility \
		-no-stl \
		-no-qt3support \
		-no-phonon \
		-no-phonon-backend \
		-no-opengl \
		-no-declarative \
		-no-scripttools \
		-no-sql-db2 \
		-no-sql-ibase \
		-no-sql-mysql \
		-no-sql-oci \
		-no-sql-odbc \
		-no-sql-psql \
		-no-sql-sqlite \
		-no-sql-sqlite2 \
		-no-sql-tds \
		-no-mmx \
		-no-3dnow \
		-no-sse \
		-no-sse2 \
		-no-multimedia \
		-nomake demos \
		-nomake docs \
		-nomake examples \
		-nomake tools \
		-nomake tests \
		-nomake translations \
		-xrender \
		-largefile \
		-iconv \
		-openssl-linked \
		-no-javascript-jit \
		-no-rpath \
		-no-dbus \
		-no-nis \
		-no-cups \
		-no-pch \
		-no-gtkstyle \
		-no-nas-sound \
		-no-sm \
		-no-xshape \
		-no-xinerama \
		-no-xcursor \
		-no-xfixes \
		-no-xrandr \
		-no-mitshm \
		-no-xinput \
		-no-xkb \
		-no-glib \
		-no-gstreamer \
		-no-icu \
		-no-openvg \
		-no-xsync \
		-no-audio-backend \
		-no-sse3 \
		-no-ssse3 \
		-no-sse4.1 \
		-no-sse4.2 \
		-no-avx \
		-no-neon

qt_build: qt_configure
	$(MAKE) -C $(QT_SRC_DIR) -j 4

qt_install: qt_build
	$(MAKE) -C $(QT_SRC_DIR) install

wkhtmltopdf_configure: qt_install
	cd $(WKHTMLTOPDF_SRC_DIR) && \
		export QTDIR=$(QT_INSTALL_PREFIX) && \
		export QMAKESPEC=$(QT_INSTALL_PREFIX)/mkspecs/linux-g++ && \
		$(QT_INSTALL_PREFIX)/bin/qmake wkhtmltopdf.pro

wkhtmltopdf_build: wkhtmltopdf_configure
	$(MAKE) -C $(WKHTMLTOPDF_SRC_DIR) -j 4

install: wkhtmltopdf_build
	$(MAKE) -C $(WKHTMLTOPDF_SRC_DIR) install INSTALL_ROOT="$(INSTALL_ROOT)"

clean:
	$(MAKE) -C $(WKHTMLTOPDF_SRC_DIR) clean || true
	$(MAKE) -C $(QT_SRC_DIR) clean || true
	rm -rf $(INSTALL_ROOT)
