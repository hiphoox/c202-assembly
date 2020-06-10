defmodule IO.Printer do 
    @moduledoc false
    
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

    def print_element(label, element, inspect \\ false)             do 
      IO.puts(label)
      if inspect,
        do:   element |> IO.inspect(),
        else: IO.puts(element)
    end

    def _print_error(class, fault_element, reason, location)        do
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
      )
    end
    def check_for_verbose(code, true) do
      IO.Printer.print_element(Common.StringElements.rc, code)
      code
    end
    def check_for_verbose(code, false) do
      code
    end
end