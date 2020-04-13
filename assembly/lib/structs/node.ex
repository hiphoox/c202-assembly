defmodule Structs.Node do
    @moduledoc """
    Defines a Node that represents a grammar production rule in the target programming language.
    """

    defstruct [:tag, :token, :children, :class, :asm]
end
