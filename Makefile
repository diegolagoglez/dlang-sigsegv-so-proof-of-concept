
all: libtest.so main

libtest.so: libtest.d
	dmd -fPIC -shared -g -defaultlib=libphobos2.so -H $< -of$@

.PHONY: lib

lib: libtest.so

main: libtest.so main.d
	dmd main.d -g -defaultlib=libphobos2.so -L=-L. -L=-ltest

.PHONY: run

run: libtest.so main
	LD_LIBRARY_PATH=. ./main

.PHONY: clean

clean:
	rm -f *.o *.so *.di main
