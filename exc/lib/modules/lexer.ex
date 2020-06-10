defmodule Lexer do
  @moduledoc """
  Breaks the source code string (SCS) into an output list of tokens (OTL).
  """

  @doc """
  Returns an output list of tokens (OTL) by breaking the source code string (SCS).
  ## Specs 
  ```arg``` is a tuple that contains the following elements:
  + **source_code_string**: source code string.
  + **general_token_list**: target language's valid token list. Refer to 
      `Reader.read_code_and_tokens/3` for more information.
  ## Examples
      iex> source = Reader.read_code_and_tokens("examples/test_s2.c", 
          "specification_files/c_tokens.xml")
      iex> Lexer.tokenize(source)
  """
  def tokenize({source_code_string, general_token_list})                do
    lex(source_code_string, general_token_list, [])
  end

  defp lex("", _, output_token_list)                                    do
    error_token = Enum.find(output_token_list, fn x -> x.tag == "error" end)
    if error_token == nil do
      {output_token_list, :ok}
    else
      {error_token, :error}
    end
  end

  defp lex(source_code_string, general_token_list, output_token_list)   do
    # source_code_string = source code without '\n' and '\t' chars.
    {token, match} = Enum.reduce_while(
      general_token_list,
      {"",""},
      fn token, _ ->
        if (regex_matches =
          Regex.run(~r/^\s*#{token.expression}\s*/, source_code_string)
        ) == nil,
        do:   {:cont, {token, :error}},
        else: {:halt, {token, Enum.at(regex_matches,0)}}
      end
    )
    t = %{token | expression: String.trim(match)}
    lex(
      #remove from source_code_string the matched token
      String.replace_prefix(source_code_string, match, ""),
      general_token_list,
      output_token_list ++ [t]
    )
  end
end