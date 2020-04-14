defmodule Invoker do
    @moduledoc """
    Generates the assembly output file. 
    """
    @doc """
    Returns a file ```foo.s``` that contains the assembly code of the source input program.
    
    ### Specs  
    ```file``` is the path to the file to be compiled.

    """
    def invoke_gcc(file) do
        bfn = Path.basename(file, ".s")
        System.cmd("gcc", [file, "-o#{bfn}"])
    end
end
