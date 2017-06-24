include build_config.mk


.PHONY: all app lib collect clean $(BUILD_DEPEND_LIBS) $(BUILD_TARGET_LIBS) 

all: app lib


app: lib
	$(MAKE) -C 	$(BUILD_TARGET_APPS)
	$(MAKE) -C 	$(BUILD_TARGET_APPS) install


lib: $(BUILD_TARGET_LIBS) collect

$(BUILD_TARGET_LIBS): $(BUILD_DEPEND_LIBS)
	$(MAKE) -C 	$@

$(BUILD_DEPEND_LIBS):
	$(MAKE)	-C 	$@

collect: $(BUILD_TARGET_LIBS)
	@- for d in $(BUILD_TARGET_LIBS) $(BUILD_DEPEND_LIBS); \
		do \
			$(MAKE) -C 	$$d  install; \
		done
#	Here can do: shared libs & headers copy to dest folder ... 




clean:
	@- for d in $(BUILD_TARGET_APPS) $(BUILD_TARGET_LIBS) $(BUILD_DEPEND_LIBS); \
		do \
			$(MAKE) -C 	$$d  clean; \
		done
#	Here can remove dest folder ...
	@- rm -rf $(DEST)

