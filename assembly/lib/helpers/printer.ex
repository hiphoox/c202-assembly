defmodule Helpers.Printer do 

    @unicode_start "\u001B["
    @unicode_finish "m"

    @styles %{:reset => "#{@unicode_start}0#{@unicode_finish}", :bold => "#{@unicode_start}1#{@unicode_finish}", :underline => "#{@unicode_start}4#{@unicode_finish}"}
    @colors %{:red => "#{@unicode_start}31#{@unicode_finish}"}

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
        IO.puts("OAST")
        IO.puts(Helpers.ASTTraveler.travel(oast_root, 0))
    end

    def _print_error(class, fault_element, reason, location) do
        IO.puts(@colors[:red] <> class <> " \'" <> @styles[:bold] <>  @colors[:red] <> "#{fault_element}" <> @styles[:reset] <> @colors[:red] <> "\'" <> reason <> " in file "  <> @styles[:underline] <> "#{location}" <> @styles[:reset])
    end

end