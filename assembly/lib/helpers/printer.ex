defmodule Helpers.Printer do 

    @styles %{:reset => "\u001B[0m", :bold => "\u001B[1m"}
    @colors %{:red => "\u001B[31m"}

    def scs(scs) do 
        scs 
        |> IO.inspect(label: "SCS") 
    end
    def gtl(gtl) do 
        gtl 
        |> IO.inspect(label: "GTL") 
    end
    def otl(otl) do 
        otl 
        |> IO.inspect(label: "OTL") 
        
    end
    def cg(cg) do 
        IO.puts("CG")
        IO.puts(cg)
    end
    def oast(oast_root) do
        IO.puts eat(oast_root, 0)
    end
    def eat(root, num) do 
        if num == 0, do: IO.puts "{#{root.tag} => {#{decide(root)}}}"
        Enum.map(root.children, fn x -> if x.children == [], do: "\n" <> String.duplicate("\t", num + 1) <> "{#{x.tag} => #{x.token.expression}}", else: "\n" <> String.duplicate("\t", num + 1) <> "{#{x.tag} => #{decide(x)}}" <> "#{eat(x, num + 1)}" end)
    end
    def decide(node) do 
        if node.token == nil, do: "\''", else: node.token.expression
    end

    def _print_error(class, fault_element, reason, location) do
        IO.puts(@colors[:red] <> class <> " \'" <> @styles[:bold] <>  @colors[:red] <> "#{fault_element}" <> @styles[:reset] <> @colors[:red] <> "\' " <> reason <> " in file "  <> "#{location}" <> @styles[:reset])
    end

end