module tplInstall;

import std.file : copy, dirEntries, exists, isFile, readText, thisExePath, write, mkdirRecurse,SpanMode;
import std.path : buildPath, dirName, setExtension, stripExtension, relativePath;
import std.process : environment;
import std.string : replace;
import std.stdio : writeln;

void templateInstall(){
    string home = environment.get("HOME", "~");
    string tplPath = buildPath(home,".tengine-tools/templates");

    if(exists(tplPath)) return;

    writeln("Initializing templates...");

    mkdirRecurse(tplPath);
    string exeDir = thisExePath().dirName;
    string srcDir = buildPath(exeDir, "../templates");

    foreach (e; dirEntries(srcDir, SpanMode.depth)) {
        if (!e.isFile) continue;

        string rel = relativePath(e.name, srcDir);
        string dst = buildPath(tplPath, rel);
        mkdirRecurse(dst.dirName);
        copy(e.name, dst);
    }

    writeln("Templates initialized to: ", tplPath);
}