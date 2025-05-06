module parser;
import std;

string[string] argsParser(string[] args){
    if (args.length < 2) {
        return errorMsg();
    }
    string[string] vars;
    switch(args[1]){
        case "init":
            if(args.length < 3) return errorMsg();
            vars["command"] = args[1];
            vars["projectName"] = args[2];
            break;
        case "run":
            vars["comannd"] = args[1];
            break;
        case "set":
            if(args.length < 3) return errorMsg();
            vars["command"] = args[1];
            vars["tenginePath"] = args[2];
            break;
        case "build":
            vars["command"] = args[1];
            break;
        case "help":
            vars["command"] = args[1];
            break;
        case "install-templates":
            vars["command"] = args[1];
            break;
        default:
            write("tengine-tools: unknown command");
            foreach (key; args) {
                write(key ~ " ");
            }
            writeln();
            return errorMsg();
            break;
    }
    return vars;
}

string[string] errorMsg(){
    writeln("Usage: tengine-tools [command]");
    writeln("command: build, init <project-name>, run, set <tengine-lib-path>, help");
    string[string] res;
    res["command"] = "error";
    return res;
}