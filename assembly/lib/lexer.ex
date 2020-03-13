defmodule Lexer do

    def tokenize({scs, gtl, _gast}) do
        Hps.TokenListProcessor.clean(scs)
        |> lex(gtl)
    end

    def lex(string, gtl, output \\ [])
    def lex("", gtl, output) when length(gtl)-1 != length(output) do
        :error_token_not_present
    end
    def lex("", _, output) do
        output
    end
    def lex(string, gtl, output) do
        {token, match} = Enum.reduce_while(gtl, {"",""}, fn x, _ -> if (regex_match = Regex.run(~r/^\s*#{x.expression}\s*/, string)) == nil, do: {:cont, {x, :error}}, else: {:halt,{x, Enum.at(regex_match,0)}} end)
        token = %{token | expression: String.trim(match)}
        lex(String.replace_prefix(string, match, ""), gtl, output ++ [token])
    end
end