import std.stdio : writeln;
import std.file : readText, write, mkdirRecurse;
import std.string : replace;

void main(string[] args) {
    if (args.length < 2) {
        writeln("Usage: generate <name>");
        return;
    }

    string name = args[1];

    // テンプレート読み込み
    string templatePath = "templates/hello.tpl";
    string templateText = readText(templatePath);

    // テンプレート中の {{name}} を置換
    string code = templateText.replace("{{name}}", name);

    // 出力先に書き込み
    string outputPath = "output/" ~ name ~ ".c";
    mkdirRecurse("output");
    write(outputPath, code);

    writeln("Generated: ", outputPath);
}