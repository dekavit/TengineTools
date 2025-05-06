module init;

import std.array;
import std.file : copy, dirEntries, exists, isFile, readText, thisExePath, write, mkdirRecurse,SpanMode;
import std.json;
import std.path : buildPath, dirName, pathSplitter, setExtension, stripExtension, relativePath;
import std.process : environment;
import std.string : replace;
import std.stdio : writeln;

void generateTemplates(string[string] vars){
    string home = environment.get("HOME", "~");
    string tplPath = buildPath(home,".tengine-tools/templates");
    string configPath = buildPath(home,".tengine-tools/config.json");
    if(!exists(tplPath)){
        writeln("tengine-tools: template not found");
        return;
    }
    if(!exists(configPath)){
        writeln("tengine-tools: config.json not found.");
        writeln("Usage: tengine-tools set <tengine-lib-path>");
        return;
    }
    string json_string = readText(configPath);
    JSONValue json = parseJSON(json_string);
    if(json["tenginePath"].str==null){
        writeln("tengine-tools: config.json error");
        writeln("Usage: tengine-tools set <tengine-lib-path>");
        return;
    }
    vars["tenginePath"] = json["tenginePath"].str;
    string outputRoot = buildPath("./",vars["projectName"]);
    mkdirRecurse(outputRoot);
    foreach (entry; tplPath.dirEntries(SpanMode.depth)) {
        if(!entry.isFile) continue;
        string relPath = relativePath(entry.name, tplPath);
        string outPath = buildPath(outputRoot, relPath);
        mkdirRecurse(outPath.dirName);
        auto relRoot = pathSplitter(relPath).array[0];
        if(relRoot=="assets"){
            copy(entry.name, outPath);
        }else{
            string tpl = readText(entry.name);
            string result = applyTemplate(tpl,vars);
            write(outPath, result);
        }
        writeln("Generated: ", outPath);
    }
}

string applyTemplate(string tpl, string[string] vars) {
    foreach (k, v; vars) {
        tpl = tpl.replace("{{" ~ k ~ "}}", v);
    }
    return tpl;
}