defmodule Hps.OASTPrinter do 
    def print(oast) do
        if oast == nil do 
            IO.puts generate_program() |> process(0)
        else
            process(oast)
        end
    end

    def generate_program() do
        #defstruct [:tag, :token, :children, :class, :asm] 
        data_type = %Structs.Node{tag: "int", token: "int", children: [], class: ["data-type"], asm: "", parent: nil}
        main_function_name = %Structs.Node{tag: "main", token: "main", children: [], class: ["function-name"], asm: "", parent: nil}
        evaluator_open = %Structs.Node{tag: "(", token: "parenthesis_open", children: [], class: ["group-opener", "args-opener"], asm: "", parent: nil}
        evaluator_close = %Structs.Node{tag: ")", token: "parenthesis_close", children: [], class: ["group-closer", "args-closer"], asm: "", parent: nil}
        section_open = %Structs.Node{tag: "{", token: "bracket_open", children: [], class: "function-opener", asm: "", parent: nil}
        section_close = %Structs.Node{tag: "}", token: "bracket_close", children: [], class: "function-closer", asm: "", parent: nil}
        literal = %Structs.Node{tag: "[0-9]+", token: "literal", children: [], class: "evaluation", asm: "mov :t, :r", parent: nil}
        semicolon = %Structs.Node{tag: ";", token: "semicolon", class: "line-ender", asm: "", parent: nil}

        return = %Structs.Node{tag: "return", token: "return", children: [literal, semicolon], class: ["operation, returner"], asm: "mov :t, :r", parent: nil}

        _function = %Structs.Node{tag: "function", token: "", children: [
            data_type,
            main_function_name,
            evaluator_open,
            evaluator_close,
            section_open,
            return, 
            section_close
        ], class: "program-root", asm: ""}
    end

    def proc(root) do
        root_str = "{#{root.tag}, #{root.token}}"
        children_str = Enum.map(root.children, fn x -> if x.children != [], do: p1(x, 2), else: p2(x, 1) end)
        "#{root_str}#{children_str}"
    end
    def p1(x, num_tabs) do 
        o = "\n" <> String.duplicate("\t", num_tabs - 1) <> "{#{x.tag}, #{x.token}}"
        c = Enum.map(x.children, fn x -> "\n" <> String.duplicate("\t", num_tabs) <> "{#{x.tag}, #{x.token}}" end)
        "#{o}#{c}"
    end
    def p2(x, num_tabs) do 
        "\n" <> String.duplicate("\t", num_tabs) <> "{#{x.tag}, #{x.token}}"
    end

    def process(root, num) do 
        if num == 0 do 
            rs = String.duplicate("\t", num) <> "{#{root.token}, #{root.tag}}"
            str = Enum.map(root.children, fn x -> if x.children == [], do: "\n" <> String.duplicate("\t", num + 1) <> "{#{x.token}, #{x.tag}}", else: process(x, num + 1) end)
            rs <> Enum.join(str)
        else
            rs = "\n" <> String.duplicate("\t", num) <> "{#{root.token}, #{root.tag}}"
            str = Enum.map(root.children, fn x -> "\n" <> String.duplicate("\t", num + 1) <> "{#{x.token}, #{x.tag}}" end)
            rs <> Enum.join(str)
        end
    end
end