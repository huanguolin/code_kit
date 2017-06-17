include ../../compile_config.mk
include ../../release_version.mk

############################################################################
# Beginming of Developer Modification 
############################################################################

# for building program
application_NAME        := hello 
# for building library
library_NAME            := 

# share library version option
SHARED_LIB_VERSION      := $(RELEASE_VERSION)

project_SRCS			:= hello.c

# build option
project_DEPENDS_DIRS    := $(LIB_FOO_DIR) $(LIB_BAR_DIR) 
project_INCLUDE_DIRS    := $(LIB_FOO_DIR) $(LIB_BAR_DIR) 
project_LIBRARY_DIRS    := $(LIB_FOO_DIR) $(LIB_BAR_DIR) 

project_STATIC_LIBS     := bar
project_SHARED_LIBS     := foo

CFLAGS      += -Wall -fPIC
CPPFLAGS    += 
LDFLAGS     +=  
############################################################################
# End of Developer Modification 
############################################################################

include ../../compile_rule.mk

