defmodule Lexer do

    def tokenize({scs, gtl, _}) do
        Hps.TokenListProcessor.clean(scs)
        |> lex(gtl)
    end

    def lex(string, gtl, output \\ [])
    def lex("", _, output), do: output
    def lex(string, gtl, output) do
        {token, match} = Enum.reduce_while(gtl, {"",""}, fn x, _ -> if (regex_match = Regex.run(~r/^\s*#{x.expression}\s*/, string)) == nil, do: {:cont, {x, :error}}, else: {:halt,{x, Enum.at(regex_match,0)}} end)
        if match == :error do
            token
        else
            token = %{token | expression: match}
            lex(String.replace_prefix(string, match, ""), gtl, output ++ [token])
        end
    end
end