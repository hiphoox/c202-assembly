defmodule Helpers.TokenListProcessor do
    def proc_list([]), do: []
    def proc_list([ head | tail]), do: [ head.expression | proc_list(tail)]
end