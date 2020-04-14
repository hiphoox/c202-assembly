defmodule Invoker do
    @moduledoc """
    Generates the assembly output file. 
    """
    @doc """
    Invokes ```gcc``` to produce an executable file.
    
    ### Specs  
    ```file``` is the path to the file to be compiled.

    """
    def invoke_gcc(assembly_source_code) do
        target_code_name = Path.basename(assembly_source_code, ".s")
        System.cmd("gcc", [assembly_source_code, "-o#{target_code_name}"])
        File.rm!(assembly_source_code)
    end
end
