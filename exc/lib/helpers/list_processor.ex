defmodule Helpers.TokenListProcessor do
  @moduledoc false
  
  defp proc_list([]),             do: []
  defp proc_list([head | tail]),  do: [head.expression | proc_list(tail)]

  def generate_list_of_expressions(gtl) do
    proc_list(gtl)
  end
end