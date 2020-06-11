defmodule Error.RowColDetecter do
  @moduledoc """
    Module that identifies the row and column inside the source code string of the fault token identified in the lexing process.
  """

  @doc """
  Given a token and a source code string, it will return a tuple containing the row and column of the token inside the source code.
  As a side note, the source code string must be raw, which means it should contain the newline and tabs special characters.
  ## Specs
    ```token``` fault token identified in the `Lexer` output.

    ```raw_source_code_string``` contains the source code string with special characters removals like newline or tabs.
  """
  def find_row_col(token, raw_source_code_string) do
    {num_row, row} = find_row(token, raw_source_code_string)
    num_col = find_col(token, row)
    {num_row + 1, num_col + 1}
  end

  defp find_row(token, source_code_string) do
    chunks = String.split(source_code_string, "\n")
    num_row = chunks
                |> find(token, _row=true)
    row = Enum.at(chunks, num_row)
    {num_row, row}
  end

  defp find_col(token, row) do
    String.split(row, " ")
      |> find(token, _row=false)
  end

  defp find(list, token, _row=true) do
    Enum.reduce_while(list, 0, fn x, acc ->
      if String.contains?(x, "#{token.expression}"),
      do: {:halt, acc},
      else: {:cont, acc + 1}
    end)
  end

  defp find(list, token, _row=false) do
    Enum.reduce_while(list, 0, fn x, acc ->
      if String.contains?(x, "#{token.expression}"),
      do: {:halt, acc},
      else: {:cont, acc + String.length(x) + 1}
    end)
  end
end
