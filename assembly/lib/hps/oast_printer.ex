defmodule Hps.OASTPrinter do 
    def print(oast_root) do
        [function | _t] = oast_root.children
        IO.puts process(function, 0)
    end
    def process(root, num) do 
        if num == 0 do 
            rs = String.duplicate("\t", num) <> "{#{root.token}, #{root.tag}}"
            str = Enum.map(root.children, fn x -> if x.children == [], do: "\n" <> String.duplicate("\t", num + 1) <> "{#{x.token.expression}, #{x.tag}}", else: process(x, num + 1) end)
            rs <> Enum.join(str)
        else
            rs = "\n" <> String.duplicate("\t", num) <> "{#{root.token.expression}}"
            str = Enum.map(root.children, fn x -> "\n" <> String.duplicate("\t", num + 1) <> "{#{x.token.expression}, #{x.tag}}" end)
            rs <> Enum.join(str)
        end
    end
end