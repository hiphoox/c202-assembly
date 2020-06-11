defmodule Filter do 
  @moduledoc """
  Filters the outputs of `Lexer.tokenize/1` and `Parser.parse/2`. 
  """

  @doc """
  ## Specs
  Given the output of the `Lexer`, it prints any lexing errors or continues 
      with the compilation if there are none.

  ```arg``` is a tuple that contains the following elements:
  + **output_token_list**: list of all the tokens found in the source code. 
      Refer to `Structs.Token` for more information. 
  + **status**: atom indicating if there was an invalid token in the source code.

  ```source_code_path``` is the path to the file to be compiled. 
  
  ```verbose``` a boolean value indicating if the compiler should output all 
      of its steps.
  """
  def filter_lexer_output({error_token, :error}, source_code_path, 
    raw_source_code_string, _)               do 
    Error.ErrorDetecter.lexer_error(error_token, source_code_path, 
      raw_source_code_string)
    System.halt(1)
  end
  def filter_lexer_output({otl, :ok}, _, _, verbose)                          do
    if verbose do
      inspect = true
      IO.Printer.print_element(
        Common.StringElements.otl, 
        otl, 
        inspect
      )
    end
    otl
  end

  @doc """
  ## Specs
  Given the output of the `Parser`, it prints any parsing errors or continues 
      with the compilation if there are none.

  ```arg``` is a tuple that contains the following elements:
  + **status**: atom indicating if there was an invalid token in the source code.
  + **output_abstract_syntax_tree**: Abstract Syntax Tree (OAST) generated 
      given Output Token List (OTL).
  + **token_list**: list of all the bad tokens found in the source code
  + **error_cause**: string containing the cause of the bad tokens.
  
  ```source_code_path``` is the path to the file to be compiled. 

  ```verbose``` a boolean value indicating if the compiler should output all of
      its steps.
  """
  def filter_parser_output({error_token, _, token_list, 
    error_cause, otl}, source_code_path,raw_scs, _) do
    {ast_not_matched, error_token_list} = error_cause
    position_tuple = Lexer.find_error_position(raw_scs, otl, error_token_list)
    Error.ErrorDetecter.parser_error(error_token, token_list, ast_not_matched, 
      source_code_path, position_tuple)
    System.halt(1)
  end

  def filter_parser_output({_,output_abstract_syntax_tree,_,_}, _, _, 
    _verbose=true) do
    oast_string = IO.ASTTraveler.travel(output_abstract_syntax_tree, 0)
    IO.Printer.print_element(Common.StringElements.oast, oast_string)
    output_abstract_syntax_tree
  end

  def filter_parser_output({_,output_abstract_syntax_tree,_,_}, _, _, 
    _verbose=false) do
    output_abstract_syntax_tree
  end

  def filter_output_file_name(file_path, "")                              do
    Path.basename(file_path, ".s")
  end

  def filter_output_file_name(_file_path, output_file_name)               do 
    output_file_name
  end
end