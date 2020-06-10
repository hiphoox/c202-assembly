defmodule CodeConnector do 
  def connect(code, verbose) do 
    code
      |> assembly()
      |> check_for_verbose(verbose)
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
  defp check_for_verbose(assembly_code, verbose)                            do
    if verbose do
      IO.Printer.print_element(
        Common.StringElements.rc, assembly_code
      )
    end
    assembly_code
  end
end