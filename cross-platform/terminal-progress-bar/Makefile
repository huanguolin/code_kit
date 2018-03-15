
CPPFLAGS	+= -Ilib
LDFLAGS		+= -L./ -lprogress 

all: libprogress.a demo

demo: example/demo.o
	$(LINK.cc) $^ -o $@ $(LDFLAGS) 

libprogress.a: lib/print_progress.o
	$(AR) cr $@ $^ 
	

clean: 
	$(RM) -f lib/*.o 
	$(RM) -f example/*.o
	$(RM) -f libprogress.a demo
