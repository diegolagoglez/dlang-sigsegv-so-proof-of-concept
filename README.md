# Proof of concept of how D compiler (dmd) generates a binary that throws a SIGSEGV with using with *.di files

# Introduction

This repository holds a proof of concept of how D compiler (dmd) generates a binary file (test program) that throws a SIGSEGV when it is linked against a library (*.so) using an interface file (*.di) instead of a source file (*.di) when importing the library API.

Compiling the library is made with or without -H option to generate or not the interface file (*.di). After that, the test program is compiled against the library importing the source file (*.d).

With this import, [as stated in documentation](https://dlang.org/dmd-linux.html#interface-files), `dmd` uses interface files before source files if they are present.

And, when the test program is compiled using that interface file, that program throws a SIGSEGV on every run.

# How to compile the library

```make
dmd -fPIC -shared -defaultlib=libphobos2.so -H libtest.d -oflibtest.so
```

`-H` is the key of the proof of concept. If it is set, D compiler (dmd) generates `libtest.di` as an interface file, and when compiling the test program, `dmd` primary uses this file instead of `libtest.d`, and this throws a SIGSEGV when the test program calls the function implemented in the library. That SIGSEGV is not thrown when `dmd` uses the source file (*.d) instead of the interface file (*.di).

# How to compile the test program

```make
dmd main -defaultlib=libphobos2.so -L=-L. -L=-ltest
```

# How to run the test

```bash
LD_LIBRARY_PATH=. ./main
```

# Using `make`

There is a `Makefile` to automate all previous tasks and works as follows:

```bash
make clean  # cleans all compiled/generated files
make run    # compiles the library without -H, the test program an runs it
make run-di # compiles the library with -H, the test programa and runs it
```

# Hardware and software used

* OS  : Ubuntu 16.04.3 LTS
* Arch: i386
* dmd : 2.078.1 (installed from DEB package)

# Credits

[Diego Lago](mailto:diego.lago.gonzalez@gmail.com)

Repository: [GitHub](https://github.com/diegolagoglez/dmd-sigsegv-using-di-proof-of-concept)
2018-02-21
