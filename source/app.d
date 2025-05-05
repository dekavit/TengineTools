import std.stdio;
import std.file;
import std.string;

void main(string[] args) {
    if (args.length < 2) {
        writeln("Usage: generate <name>");
        return;
    }

    string name = args[1];
    string code = generateCTemplate(name);

    string path = "output/" ~ name ~ ".c";
    mkdirRecurse("output");
    std.file.write(path, code);

    writeln("Generated: ", path);
}

string generateCTemplate(string name) {
    return q{
#include <stdio.h>

int main() {
    printf("Hello, World!\n");
    return 0;
}
};
}
