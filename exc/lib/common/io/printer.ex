defmodule IO.Printer do
    @moduledoc """
    Prints elements and errors on screen.
    """

    @unicode_start  "\u001B["
    @unicode_finish "m"

    @styles %{
      :reset      => "#{@unicode_start}0#{@unicode_finish}",
      :bold       => "#{@unicode_start}1#{@unicode_finish}",
      :underline  => "#{@unicode_start}4#{@unicode_finish}"
    }
    @colors %{
      :red        => "#{@unicode_start}31#{@unicode_finish}"
    }

    @doc """
    ## Specs
    ```label```  String with the element name.

    ```element``` Element to print.

    ```inspect``` Boolean indicating if something is going to be printed or not.
    """

    def print_element(label, element, inspect \\ false)             do
      IO.puts(label)
      if inspect,
        do:   element |> IO.inspect(),
        else: IO.puts(element)
    end

    @doc """
    Method that handles the pretty printing process.
    ## Specs
    ```class``` class where the error occurred.

    ```fault_element``` fault token that produced the error.

    ```reason``` message that indicating the reason for the error.

    ```location``` path the the file containing the error.

    ```row_col``` string that containts the row and col of the error.
    """
    def _print_error(class, fault_element, reason, location, row_col) do
      IO.puts(
        @colors[:red]
        <> class
        <> " \'" <> @styles[:bold]
        <>  @colors[:red]
        <> "#{fault_element}"
        <> @styles[:reset] <> @colors[:red]
        <> "\'"
        <> reason <> " in file "
        <> @styles[:underline]
        <> "#{location}"
        <> @styles[:reset]
        <> "#{row_col}"
      )
    end

    @doc """
    Method that helps ExC modules to check if the output should be verbosed or not. 
    The modules that call this method are `CodeGenerator`, `CodeOptimizer` and `CodeConnector`. 
    ## Specs
      ```code```  assembly code to be printed.

      ```module_str``` string that identifies the calling method. To use this correctly, use the module `Common.StringElements` and call the appropiate method for the desired module.
      
      ```verbose``` Boolean indicating if the output should be shown.
    """
    def check_for_verbose(code, module_str, true) do
      IO.Printer.print_element(module_str, code)
      code
    end
    def check_for_verbose(code, _module_str, false) do
      code
    end
end
