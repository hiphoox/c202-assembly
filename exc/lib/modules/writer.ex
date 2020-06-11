defmodule Writer do
    @moduledoc """
    Writes the target language code (assembly x86 64 bit) file to the current
    working directory.
    """
    @doc """
    Writes the assembly file, ```exc_o.s``` using the code generated by `CodeGenerator.generate_code/2`.

    ### Specs
    ```code```is the assembly code generated by the `CodeGenerator.generate_code/2`

    Returns ```exc_o.s``` file that contains the assembly code generated by the ExC.
    """
    def write_file(code)                    do
        output_file_path = build_path()
        File.write(output_file_path, code)
        output_file_path
    end

    defp build_path()                       do
        Common.StringElements.asm_generated_file()
    end
end
