module set;

import std.file : exists, readText, write;
import std.json;
import std.path : buildPath;
import std.process : environment;

void tengineLibSet(string[string] vars){
    string home = environment.get("HOME", "~");
    string configPath = buildPath(home,".tengine-tools/config.json");
    string json_string;
    if(exists(configPath)){
        json_string = readText(configPath);
    }
    JSONValue json = parseJSON(json_string);
    json["tenginePath"] = vars["tenginePath"];
    write(configPath, json.toString);
}