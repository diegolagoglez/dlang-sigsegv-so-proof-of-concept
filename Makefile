
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

