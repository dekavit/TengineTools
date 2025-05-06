
import tpl_install;
import init;
import parser;
import set;


void main(string[] args) {

    auto vars = argsParser(args);

    templateInstall();
    switch(vars["command"]){
        // case "build":
        //     break;
        // case "help":
        //     break;
        case "init":
            generateTemplates(vars);
            break;
        // case "run":
        //     break;
        case "set":
            tengineLibSet(vars);
            break;
        case "error":
            break;
        default:
            break;
    }
}