#!/bin/bash 

#----------------------------------------------------
# Auto build and package script.
#
# Auther  :	Alvin Huang
# Date    : 2017/6/17		
#----------------------------------------------------

#=========== functions ==============

print_help() 
{
	echo -e "\nbuild_all.sh command line: "
	echo -e "\t ./build_all.sh [Release Version]"
	echo -e "\t      ./build_all.sh 1.0.10 "
	echo -e "\t      ./build_all.sh \n"
}

test_error()
{
	if [ $? -ne 0 ]; then
		echo "[Error] Parameters illegal ! "
		print_help
		exit 1
	fi
}

config_release_version() 
{
	local VERSION_CONFIG_FILE=${SRC_ROOT}/release_version.mk
	local BUILD_VERSION=`git rev-list --count HEAD`
	local RELEASE_VERSION=$1

	## check if empty
	if [ -z "$1" ]; then 
		RELEASE_VERSION=1.0.1
	fi
	
	## check version format 
	if [ -z "`echo ${RELEASE_VERSION} | egrep -o "^([0-9]+\.){2}[0-9]+$" `" ]; then
		return 1
	fi

	RELEASE_VERSION=${RELEASE_VERSION}.${BUILD_VERSION}

	## write to configure file
	echo "RELEASE_VERSION := ${RELEASE_VERSION}" > ${VERSION_CONFIG_FILE}
	
	echo "${RELEASE_VERSION}"
	return 0
}

make_package()
{
	local DEST_DIR="dest"
	local TARGET_DIR="release-${TARGET_OS}-${TARGET_ARCH}-${RELEASE_VERSION}"
	local TARGET_FILE="${TARGET_DIR}.tar.gz"

	cd "${SRC_ROOT}"
	if [ ! -d ${DEST_DIR} ]; then 
		echo "Make package fail: can't found Dest folder "
		return 1
	fi
	mkdir -p ${TARGET_DIR}
	mv -v ${DEST_DIR}/*	${TARGET_DIR}
	tar czvf ${TARGET_FILE}	${TARGET_DIR}
	mv -vf ${TARGET_FILE}	${DEST_DIR}
	rm -rf ${TARGET_DIR}
	cd -
}


#**********************  main  ***********************
CUR_DIR=`dirname $(readlink -f ${BASH_SOURCE[0]})`
SRC_ROOT="${CUR_DIR}/.." 

echo "Project Root Diretory: ${SRC_ROOT}"

##--- release version config ---
RELEASE_VERSION=$(config_release_version $1) 
test_error
echo "LIB_VERSION: ${RELEASE_VERSION}"

##--- target OS confirm ---
TARGET_OS=`lsb_release -is`_`lsb_release -rs`
echo "TARGET_OS: ${TARGET_OS}"

##--- target arch confirm ---
TARGET_ARCH=`uname -m`
echo "TARGET_ARCH: ${TARGET_ARCH}"

#------ build all -------
sleep 3
make -C "${SRC_ROOT}" clean
make -C "${SRC_ROOT}" 

if [ $? -ne 0 ]; then 
	echo "[Error] make fail ! "
	exit 1
else
	echo "make success ! "
fi


#--- package ---
make_package

exit 0

