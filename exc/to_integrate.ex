  defp find_error_position(scs, otl, etl) do
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
      traverse_errors(Enum.join(rest_of_scs,""), tail, new_x_start + String.length(last_chars) + 1, new_y_start)
    else
      new_x_start = pos_x
      new_y_start = pos_y
      last_chars = Regex.split(~r/\n/, previous_chars) |> List.last
      traverse_errors(Enum.join(rest_of_scs,""), tail, new_x_start + String.length(last_chars) + 1, new_y_start)
    end
  end