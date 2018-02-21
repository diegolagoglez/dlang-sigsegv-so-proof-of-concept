# Makefile to build the library and the test program to
# show how D compiler (dmd) generates a binary that throws
# a SIGSEGV when the test program is compiled using *.di
# file instead of *.d file of the library. 
#
# Diego Lago <diego.lago.gonzalez@gmail.com>
# Proof of concept v0.1 2018-02-21

EXE := main
EXE_SRC := main.d
SO := libtest.so
SONAME := test
SO_SRC := libtest.d

all: $(SO) $(EXE)

DI_OPTION :=

$(SO): libtest.d
	dmd -fPIC -shared -defaultlib=libphobos2.so $(DI_OPTION) $< -of$@

.PHONY: lib

lib: $(SO)

$(EXE): $(SO) $(EXE_SRC)
	dmd $(EXE_SRC) -defaultlib=libphobos2.so -L=-L. -L=-l$(SONAME)

.PHONY: run

run-di: DI_OPTION := -H
run-di: run

run: $(SO) $(EXE)
	LD_LIBRARY_PATH=. ./$(EXE)

.PHONY: clean

clean:
	rm -f *.o *.so *.di $(EXE)

