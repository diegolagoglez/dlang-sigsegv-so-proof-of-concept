import libtest;

import std.stdio;

int
main(string[] args) {
	writefln("before print_hello()");
	print_hello();
	writefln("after print_hello()");
	writefln("before new HelloPrinter()");
	auto helloPrinter = new HelloPrinter();
	writefln("after new HelloPrinter()");
	writefln("before helloPrinter.printHello()");
	helloPrinter.printHello();
	writefln("after helloPrinter.printHello()");
	return 0;
}

