defmodule Lexer do
    @moduledoc """
    Breaks the source code string (SCS) into an output list of tokens (OTL).
    """

    @doc """
    Returns an output list of tokens (OTL) by breaking the source code string (SCS).
    ## Specs 
    ```arg``` is a tuple that contains the following elements:
    + **source_code_string**: source code string.
    + **general_token_list**: target language's valid token list. Refer to `Reader.read_code_and_tokens/3` for more information.
    ## Test Example
        >iex source = Reader.read_code_and_tokens("../examples/test_s2.c", "./specification_files/c_tokens.xml")
        >iex Lexer.tokenize(source)
        "Structs.Token{expression: "int\\s+", pos_x: nil, pos_y: nil, tag: "int"},
        %Structs.Token{expression: "main", pos_x: nil, pos_y: nil, tag: "main"},
        %Structs.Token{
            expression: "\\(",
            pos_x: nil,
            pos_y: nil,
            tag: "parenthesis-open"
        },
        %Structs.Token{
            expression: "\\)",
            pos_x: nil,
            pos_y: nil,
            tag: "parenthesis-close"
        },
        %Structs.Token{expression: "{", pos_x: nil, pos_y: nil, tag: "bracket-open"},
        %Structs.Token{expression: "}", pos_x: nil, pos_y: nil, tag: "bracket-close"},
        %Structs.Token{
            expression: "return\\s+",
            pos_x: nil,
            pos_y: nil,
            tag: "return"
        },
        %Structs.Token{expression: "[0-9]+", pos_x: nil, pos_y: nil, tag: "literal"},
        %Structs.Token{expression: ";", pos_x: nil, pos_y: nil, tag: "semicolon"},
        %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"},
        %Structs.Token{expression: "!", pos_x: nil, pos_y: nil, tag: "negation"},
        %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, tag: "complement"},
        %Structs.Token{expression: "\\S+", pos_x: nil, pos_y: nil, tag: "error"}"
    """
    def tokenize({source_code_string, general_token_list}) do
        lex(source_code_string, general_token_list, [])
    end

    defp lex("", _, output_token_list) do
        err = Enum.find(output_token_list, fn x -> x.tag == "error" end)
        if err == nil do
            {output_token_list, :ok}
        else
            {err, :error}
        end
    end
    defp lex(source_code_string, general_token_list, output_token_list) do
        {token, match} = Enum.reduce_while(general_token_list, {"",""}, fn x, _ -> if (regex_match = Regex.run(~r/^\s*#{x.expression}\s*/, source_code_string)) == nil, do: {:cont, {x, :error}}, else: {:halt,{x, Enum.at(regex_match,0)}} end)
        t = %{token | expression: String.trim(match)}
        lex(String.replace_prefix(source_code_string, match, ""), general_token_list, output_token_list ++ [t])
    end
end