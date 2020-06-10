defmodule Common.StringElements do
  @moduledoc """
  Print the header of each output per screen
  """

  # Compiler general name modules
  def scs(),  do: "SCS"        # Source Code String
  def gtl(),  do: "GTL"        # General Token List
  def otl(),  do: "OTL"        # Output Token List
  def rc(),   do: "Raw Code"
  def oast(), do: "OAST"      # Output Abstract Syntax Tree

  # Output file names
  def asm_generated_file(), do: "output.o.s"

  #General tests strings
  def lexer_error_invalid_token(), do: "Lexer error: invalid token"
  def parser_error_missing_token(), do: "Parser error: missing token"
  def parser_error_token_not_absorbed(), do: "Parser error: token not absorbed"
end
