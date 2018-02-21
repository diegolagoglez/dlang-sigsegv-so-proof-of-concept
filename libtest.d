module libtest;

import std.stdio;

export void
print_hello() {
	writefln("Hello from function");
}

export class HelloPrinter {
	this() {
		writefln("HelloPrinter");
	}

	void printHello() {
		writefln("Hello from class");
	}
}

