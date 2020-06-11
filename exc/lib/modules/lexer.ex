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
  
  def find_error_position(scs, otl, etl) do
    number_of_errors = Kernel.length(etl)
    number_of_tokens = Kernel.length(otl)
    tokens_and_error = Enum.slice(otl, 0, number_of_tokens-number_of_errors+1)
    traverse_errors(scs, tokens_and_error)
  end

  defp traverse_errors(scs, tl, pos_x \\ 0, pos_y \\ 0)

  defp traverse_errors(_scs, [], pos_x, pos_y) do
    {pos_x, pos_y}
  end

  defp traverse_errors(scs, tl, pos_x, pos_y) do
    [head | tail] = tl
    {_res_token, expression} = Regex.compile(Regex.escape(head.expression))
    [previous_chars, _found_token | rest_of_scs] = Regex.split(expression, scs, include_captures: true)
    jump_lines = Regex.scan(~r/\n/, previous_chars) |> length
    if jump_lines > 0 do
      new_x_start = 0
      new_y_start = pos_y + jump_lines
      last_chars = Regex.split(~r/\n/, previous_chars) |> List.last
      traverse_errors(Enum.join(rest_of_scs,""), tail, new_x_start + String.length(last_chars), new_y_start)
    else
      new_x_start = pos_x
      new_y_start = pos_y
      last_chars = Regex.split(~r/\n/, previous_chars) |> List.last
      traverse_errors(Enum.join(rest_of_scs,""), tail, new_x_start + String.length(last_chars), new_y_start)
    end
  end
end