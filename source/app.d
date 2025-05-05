import std.file : readText, write, mkdirRecurse;
import std.path : buildPath;
import std.process : environment;
import std.stdio : writeln;
import std.string : replace;

import tplInstall;
import init;
import parser;

void main(string[] args) {

    auto vars = argsParser(args);

    templateInstall();
    switch(vars["command"]){
        case "init":
            string home = environment.get("HOME", "~");
            string tplPath = buildPath(home, ".tengine_tools/templates");
            generateTemplates(vars, "./");
            break;
        case "run":
            break;
        case "build":
            break;
        case "help":
            break;
        case "error":
            break;
        default:
            break;
    }
}