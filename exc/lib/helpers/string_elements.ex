defmodule Helpers.StringElements do 
    @moduledoc false
    
    # Compiler general name modules 
    def scs(), do: "SCS"        # Source Code String    
    def gtl(), do: "GTL"        # General Token List
    def otl(), do: "OTL"        # Output Token List
    def rc(), do: "Raw Code" 
    def oast(), do: "OAST"      # Output Abstract Syntax Tree

    # Output file names
    def asm_generated_file(), do: "exc_o.s"
end