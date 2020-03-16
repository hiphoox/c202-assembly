defmodule Hps.OASTPrinter do 
    def print(oast_root) do
        IO.puts eat(oast_root, 0)
    end
    def eat(root, num) do 
        Enum.map(root.children, fn x -> if x.children == [], do: "\n" <> String.duplicate("\t", num + 1) <> "{#{x.tag} => #{x.token.expression}}", else: "\n" <> String.duplicate("\t", num + 1) <> "{#{root.tag} => #{decide(x)}}" <> "#{eat(x, num + 1)}" end)
    end
    def decide(node) do 
        if node.token == nil, do: "\''", else: node.token.expression
    end
end