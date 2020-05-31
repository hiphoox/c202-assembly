defmodule Invoker do
    @moduledoc """
    Generates the assembly output file. 
    """
    @doc """
    Invokes ```gcc``` to produce an executable file.
    
    ### Specs  
    ```file``` is the path to the file to be compiled.

    """
    def invoke_gcc(assembly_source_code_path, output_file_name) do
        output_name = Filter.filter_output_file_name(
            assembly_source_code_path, output_file_name
        )
        System.cmd("gcc", [assembly_source_code_path, "-o#{output_name}"])
        File.rm!(assembly_source_code_path)
    end

    def invoke_test_output() do
        "./output.o;echo $?" |> String.to_charlist |> :os.cmd        
    end
end
