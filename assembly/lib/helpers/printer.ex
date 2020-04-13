defmodule Helpers.Printer do 
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
        cg 
        |> IO.inspect(label: "CG") 
    end
end