defmodule Error.ErrorDetecter do
   @moduledoc """
    Show errors in the output of `Lexer.tokenize / 1` and` Parser.parse / 2`.
    """

    @doc """
    ## Specs
      ```token``` list of all the tokens found in the source code.
      ```file_path``` is the path to the file to be compiled.
  """
  def lexer_error(token, file_path, raw_source_code_string)   do
    {row, col} = Error.RowColDetecter.find_row_col(token, raw_source_code_string)
    class_msg =         "** (Lexer Error) invalid token"
    fault_element_msg = "#{token.expression}"
    reason_msg  =       ""
    location_msg =      "#{file_path}"
    row_col_msg =       ":#{row}:#{col}"
    IO.Printer._print_error(
      class_msg, fault_element_msg, reason_msg, location_msg, row_col_msg
    )
  end

  @doc """
  ## Specs
    ```status``` atom indicating if there was an invalid token in the source code.
    ```tl``` list of all the bad tokens found in the source code
    ```error_cause``` string containing the cause of the bad tokens.
    ```file_path``` is the path to the file to be compiled.
  """
  def parser_error(:token_missing_error, _, error_cause, file_path, 
    position_tuple)  do
    {col, row} = position_tuple
    class_msg =         "** (Parser Error) structure"
    fault_element =     error_cause.tag
    reason_msg =        " is missing something"
    location =          file_path
    row_col_msg =       "#{row}:#{col}"
    IO.Printer._print_error(
      class_msg, fault_element, reason_msg, location, row_col_msg
    )
  end
  def parser_error(:token_not_absorbed_error, tl, _, file_path)      do
    class_msg =     "** (Parser Error) token"
    fault_element = Enum.at(tl, 0).expression
    reason_msg =    "was not accepted"
    location =      file_path
    row_col_msg =   ""
    IO.Printer._print_error(
      class_msg, fault_element, reason_msg, location, row_col_msg
    )
  end
end
