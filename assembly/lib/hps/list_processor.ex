defmodule Hps.TokenListProcessor do
    defp proc_list([]), do: []
    defp proc_list([ head | tail]), do: [ head.expression | proc_list(tail)]

    def clean(scs) do 
        String.trim(scs)
        |> String.replace("\n", " ")
        |> String.replace("\t", " ")
    end

    def generate_list_of_expressions(gtl) do
        proc_list(gtl)
    end


end