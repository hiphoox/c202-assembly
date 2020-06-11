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
    ## Specs
    ```class``` Class where the error occurred.
    ```fault_element``` Fault element.
    ```reason``` Fault indicator.
    ```location``` Place of failure.
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
    def check_for_verbose(code, module_str, true) do
      IO.Printer.print_element(module_str, code)
      code
    end
    def check_for_verbose(code, _module_str, false) do
      code
    end
end
