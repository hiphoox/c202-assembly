defmodule CodeConnector do
  @moduledoc """
  Connect the generated assembly code with the header.
  """

  @doc """
  ```code```  code generated with output `CodeOptimizer.optimize/2`.
  
  ```verbose``` a boolean value indicating if the compiler should output all of its steps.
  """
  def connect(code, verbose) do
    code
      |> assembly()
      |> IO.Printer.check_for_verbose(Common.StringElements.code_connected(),
        verbose)
  end
  defp assembly(cleaned_asm_code)                                           do
    base_header = """
        .section        __TEXT,__text,regular,pure_instructions
        .p2align        4, 0x90
    """
    main_header = """
        .globl _main
      _main:
                #{cleaned_asm_code}
        ret
    """
    base_header <> main_header
  end
end
