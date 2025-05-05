# Makefile

SUDO := sudo

APP_NAME := tengine-tools
BUILD_DIR := bin
INSTALL_DIR := /usr/local/bin
BIN_PATH := ${BUILD_DIR}/${APP_NAME}
TPL_PATH := templates
TPL_INSTALL_PATH := ${HOME}/.tengine-tools

.PHONY: all build install uninstall clean

build:
	dub build --build=release

install:
	${SUDO} install -Dm755 ${BIN_PATH} ${INSTALL_DIR}/${APP_NAME}
	@echo "Installed to ${INSTALL_DIR}/${APP_NAME}"
	mkdir -p ${TPL_INSTALL_PATH}
	cp -r ${TPL_PATH} ${TPL_INSTALL_PATH}
	@echo "Installed to ${TPL_INSTALL_PATH}"

uninstall:
	${SUDO} rm -f ${INSTALL_DIR}/${APP_NAME}
	@echo "Uninstalled from ${INSTALL_DIR}/${APP_NAME}"
	rm -rf ${TPL_INSTALL_PATH}
	@echo "Uninstalled from ${TPL_INSTALL_PATH}"

clean:
	dub clean
	rm -rf ${BUILD_DIR}
	@echo "Cleaned build artifacts"

all: clean build