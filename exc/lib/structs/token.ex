defmodule Structs.Token do
    @moduledoc """
    Defines a Token that represents a valid, or invalid, token in the target programming language.
    """

    defstruct [:tag, :expression, :pos_y, :pos_x]
end