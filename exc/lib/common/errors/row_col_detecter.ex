defmodule Error.RowColDetecter do

  def find_row_col(token, source_code_string, _read=false) do
    {num_row, row} = find_row(token, source_code_string)
    num_col = find_col(token, row)
    {num_row + 1, num_col + 1}
  end

  def find_row_col(token, source_code_path, _read=true) do
    {num_row, row} = find_row(token, File.read!(source_code_path))
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