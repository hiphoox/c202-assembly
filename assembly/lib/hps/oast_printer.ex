defmodule Hps.OASTPrinter do 
    def print(oast_root, verbose) do
        if verbose do 
            IO.puts eat(oast_root, 0)
        end
    end
    def eat(root, num) do 
        if num == 0, do: IO.puts "{#{root.tag} => {#{decide(root)}}}"
        Enum.map(root.children, fn x -> if x.children == [], do: "\n" <> String.duplicate("\t", num + 1) <> "{#{x.tag} => #{x.token.expression}}", else: "\n" <> String.duplicate("\t", num + 1) <> "{#{x.tag} => #{decide(x)}}" <> "#{eat(x, num + 1)}" end)
    end
    def decide(node) do 
        if node.token == nil, do: "\''", else: node.token.expression
    end
end