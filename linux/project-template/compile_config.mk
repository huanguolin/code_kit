# Project root path
PROJECT_ROOT_DIR    := $(dir $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))

# Library path
LIB_DIR             := $(PROJECT_ROOT_DIR)/lib

# Application path
APP_DIR             := $(PROJECT_ROOT_DIR)/app

####### Our libraries' path #######
LIB_FOO_DIR			:= $(LIB_DIR)/foo
LIB_BAR_DIR			:= $(LIB_DIR)/bar

####### Our applications' path #######
APP_HELLO_DIR		:= $(APP_DIR)/hello

####### Our share library list #######
# This projects just belong to 'lib' path.
SHARED_LIB_LIST     := libfoo

####### Output path configure #######
DEST	:= $(PROJECT_ROOT_DIR)/dest

# Default output set 
INSTALL_OUTPUT_DIR  := $(DEST)


