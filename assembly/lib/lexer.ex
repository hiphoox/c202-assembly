defmodule Lexer do
    def tokenize({scs, gtl, _}) do
        clean_scs(scs)
        |> IO.inspect()
        generate_list_of_regex(gtl)
        |> IO.inspect()
    end

    defp clean_scs(scs) do
        tc = String.trim(scs)
        Regex.split(~r/\s+/, tc)
    end
    defp generate_list_of_regex(gtl) do
        Helpers.TokenListProcessor.proc_list(gtl)
    end

    def lex_tokens(scs) when scs != "" do
        {token, rest} =
        case scs do
            
    end
end