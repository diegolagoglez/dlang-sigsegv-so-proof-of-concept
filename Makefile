
all: libtest.so main

DI_OPTION :=

libtest.so: libtest.d
	dmd -fPIC -shared -defaultlib=libphobos2.so $(DI_OPTION) $< -of$@

.PHONY: lib

lib: libtest.so

main: libtest.so main.d
	dmd main.d -defaultlib=libphobos2.so -L=-L. -L=-ltest

.PHONY: run

run-di: DI_OPTION := -H
run-di: run

run: libtest.so main
	LD_LIBRARY_PATH=. ./main

.PHONY: clean

clean:
	rm -f *.o *.so *.di main
