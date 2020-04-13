defmodule Helpers.ASTTraveler do 
    def travel(root, num) do
        if num == 0, do: "{#{root.tag} => {#{decide(root)}}}"
        Enum.map(root.children, fn x -> if x.children == [], do: "\n" <> String.duplicate("\t", num + 1) <> "{#{x.tag} => #{x.token.expression}}", else: "\n" <> String.duplicate("\t", num + 1) <> "{#{x.tag} => #{decide(x)}}" <> "#{travel(x, num + 1)}" end)
    end
    def decide(node) do 
        if node.token == nil, do: "", else: node.token.expression
    end
end