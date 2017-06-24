
include compile_config.mk
include release_version.mk

####### Dependencies for build #######
# You must pay attention to the order
BUILD_DEPEND_LIBS	:= 	$(LIB_BAR_DIR) 

####### Target library for build #######
# You must pay attention to the order
BUILD_TARGET_LIBS	:= $(LIB_FOO_DIR) 

####### Target applications for build #######
# You must pay attention to the order
BUILD_TARGET_APPS	:= $(APP_HELLO_DIR)

####### Output path configure #######
DEST				:=	$(INSTALL_OUTPUT_DIR) 

