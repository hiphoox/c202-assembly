defmodule Lexer do

    def tokenize({scs, gtl, _}) do
        Hps.TokenListProcessor.clean(scs)
        |> lex(gtl)
        |> IO.inspect()
    end

    def lex(string, gtl, output \\ [])
    def lex("", _, output), do: output
    def lex(string, gtl, output) do
        {token, match} = Enum.reduce_while(gtl, {"",""}, fn x, _ -> if (regex_match = Regex.run(~r/^\s*#{x.expression}\s*/, string)) == nil, do: {:cont, {x, :error}}, else: {:halt,{x, Enum.at(regex_match,0)}} end)
        if match == :error do
            token
        else
            lex(String.replace_prefix(string, match, ""), gtl, output ++ [{token, String.trim(match)}])
        end
    end
end