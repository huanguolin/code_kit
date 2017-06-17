
#####################################################
# Default set #
#####################################################
ifneq ($(strip $(ROOTFS)),)
    project_INCLUDE_DIRS    += $(ROOTFS)/usr/include
    project_LIBRARY_DIRS    += $(ROOTFS)/usr/lib
    LDFLAGS                 += -Wl,-rpath-link $(ROOTFS)/usr/lib
endif

#####################################################
# Library name configure #
#####################################################
ifneq ($(strip $(library_NAME)),)
    library_STATIC_NAME     	:= $(library_NAME).a
    
    ifneq ($(filter $(SHARED_LIB_LIST), $(library_NAME)),)
        library_SHARED_NAME_L   := $(library_NAME).so
        library_VERSION_SUFFIX	:= $(if $(strip $(SHARED_LIB_VERSION)), .$(strip $(SHARED_LIB_VERSION)),)
        library_SHARED_NAME 	:= $(library_SHARED_NAME_L)$(strip $(library_VERSION_SUFFIX)) 
    endif 
endif

#####################################################
# Source file ->>> Object file #						
#####################################################
ifeq ($(strip $(project_SRCS)),)
    project_C_SRCS   := $(wildcard *.c)
    project_CXX_SRCS := $(wildcard *.cpp)
    project_SRCS     := $(project_C_SRCS) $(project_CXX_SRCS)
endif
project_OBJS := $(patsubst %.c,%.o,$(project_SRCS))
project_OBJS := $(patsubst %.cpp,%.o,$(project_OBJS))

#####################################################
# Install & Clean-target file list #
#####################################################
project_INSTALL_TARGETS	:= $(application_NAME) $(library_SHARED_NAME) $(library_SHARED_NAME_L)
project_CLEAN_TARGETS	:= $(project_INSTALL_TARGETS) $(library_STATIC_NAME) $(project_OBJS) *.so.* 


#####################################################
# Flags configure #
#####################################################
#CFLAGS     += -g
#CPPFLAGS   += $(CFLAGS)
CPPFLAGS    += $(foreach includedir,$(project_INCLUDE_DIRS),-I$(includedir))
LDFLAGS     += $(foreach librarydir,$(project_LIBRARY_DIRS),-L$(librarydir))
LDFLAGS     += -Wl,-Bstatic $(foreach library,$(project_STATIC_LIBS),-l$(library))
LDFLAGS     += -Wl,-Bdynamic $(foreach library,$(project_SHARED_LIBS),-l$(library))
LDFLAGS	    += -Wl,--no-undefined
LDFLAGS	    += -Wl,-rpath=./


.PHONY: all clean dep depclean install $(project_DEPENDS_DIRS)


all: $(application_NAME) $(library_SHARED_NAME) $(library_STATIC_NAME)

$(application_NAME): $(project_OBJS) 
	$(LINK.cc) $^ -o $@ $(LDFLAGS)

$(library_STATIC_NAME): $(project_OBJS) 
	$(AR) cr $@ $^ 

$(library_SHARED_NAME): $(project_OBJS)
	$(LINK.cc) -shared $^ -o $@ $(LDFLAGS)
ifneq ($(strip $(SHARED_LIB_VERSION)),)
	ln -s $(library_SHARED_NAME) $(library_SHARED_NAME_L)
endif


dep:	$(project_DEPENDS_DIRS)

$(project_DEPENDS_DIRS):
	$(MAKE) -C $@
    

clean: 
	@- $(RM) $(project_CLEAN_TARGETS)
 

depclean: 
ifneq ($(strip $(project_DEPENDS_DIRS)),)
	@- for d in $(project_DEPENDS_DIRS); \
		do \
			$(MAKE) -C $$d clean; \
		done
endif


install: 
ifneq ($(strip $(project_INSTALL_TARGETS)),)
	@- mkdir -p $(INSTALL_OUTPUT_DIR)
	@- cp -d $(project_INSTALL_TARGETS) 		$(INSTALL_OUTPUT_DIR)
	$(shell $(project_INSTALL_CUSTOM_CMD))
endif

