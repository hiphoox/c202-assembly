defmodule Lexer do
    @moduledoc """
        Breaks the source code string (SCS) into an output list of tokens (OTL).
    """

    @doc """
        Breaks the source code string (SCS) into an output list of tokens (OTL).
        ## Specs  
        ```{source_code_string, general_token_list}``` is a tuple that contains the following elements:
            + **source_code_string**: source code
            + **general_token_list**: target language's valid token list. Refer to Reader.read_general_token_list for more information.
        
        ## Examples
        ```
            iex> otl = Lexer.tokenize({source_code_string, general_token_list})
        ``` 
    """
    def tokenize({source_code_string, general_token_list}) do
        lex(source_code_string, general_token_list)
    end

    def lex(string, gtl, output \\ [])
    def lex("", _gtl, output) do
        err = Enum.find(output, fn x -> x.tag == "error" end)
        if err == nil do
            {output, :ok}
        else
            {err, :error}
        end
    end
    def lex(string, gtl, output) do
        {token, match} = Enum.reduce_while(gtl, {"",""}, fn x, _ -> if (regex_match = Regex.run(~r/^\s*#{x.expression}\s*/, string)) == nil, do: {:cont, {x, :error}}, else: {:halt,{x, Enum.at(regex_match,0)}} end)
        t = %{token | expression: String.trim(match)}
        lex(String.replace_prefix(string, match, ""), gtl, output ++ [t])
    end
end