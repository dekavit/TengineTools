module init;

import std.file : dirEntries, exists, isFile, readText, write, mkdirRecurse,SpanMode;
import std.path : buildPath, dirName, setExtension, stripExtension, relativePath;
import std.process : environment;
import std.string : replace;
import std.stdio : writeln;

void generateTemplates(string[string] vars, string outputRoot){
    string home = environment.get("HOME", "~");
    string tplPath = buildPath(home,".tengine-tools/templates");
    if(!exists(tplPath)){
        writeln("tengine-tools: template not found");
        return;
    }
    outputRoot = buildPath(outputRoot,vars["projectName"]);
    mkdirRecurse(outputRoot);
    foreach (entry; tplPath.dirEntries(SpanMode.depth)) {
        if(!entry.isFile) continue;
        string relPath = relativePath(entry.name, tplPath);
        string outPath = buildPath(outputRoot, relPath);
        mkdirRecurse(outPath.dirName);
        string tpl = readText(entry.name);
        string result = applyTemplate(tpl,vars);
        write(outPath, result);
        writeln("Generated: ", outPath);
    }
}

string applyTemplate(string tpl, string[string] vars) {
    foreach (k, v; vars) {
        tpl = tpl.replace("{{" ~ k ~ "}}", v);
    }
    return tpl;
}