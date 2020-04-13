defmodule Filter do 
    @moduledoc """
    Filters the outputs of `Lexer.tokenize/1` and `Parser.parse/2`. 
    """

    @doc """
    ## Specs
    Given the output of the `Lexer`, it prints any lexing errors or continues with the compilation if there are none.

    ```arg``` is a tuple that contains the following elements:
    + **output_token_list**: list of all the tokens found in the source code. Refer to `Structs.Token` for more information. 
    + **status**: atom indicating if there was an invalid token in the source code.

    ```source_code_path``` is the path to the file to be compiled. 
    
    ```verbose``` a boolean value indicating if the compiler should output all of its steps.
    """
    def filter_lexer_output({otl, :error}, source_code_path, _) do 
        Helpers.ErrorDetecter.lexer_error(otl, source_code_path)
        System.halt(1)
    end
    def filter_lexer_output({otl, :ok}, _, verbose) do
        if verbose do
            Helpers.Printer.otl(otl)
        end
        {otl, :ok}
    end

    @doc """
    ## Specs
    Given the output of the `Parser`, it prints any parsing errors or continues with the compilation if there are none.

    ```arg``` is a tuple that contains the following elements:
    + **status**: atom indicating if there was an invalid token in the source code.
    + **output_abstract_syntax_tree**: Abstract Syntax Tree (OAST) generated given Output Token List (OTL).
    + **token_list**: list of all the bad tokens found in the source code
    + **error_cause**: string containing the cause of the bad tokens.
    
    ```source_code_path``` is the path to the file to be compiled. 

    ```verbose``` a boolean value indicating if the compiler should output all of its steps.
    """
    def filter_parser_output({:token_missing_error, _, token_list, error_cause}, source_code_path, _) do
        Helpers.ErrorDetecter.parser_error(:token_missing_error, token_list, error_cause, source_code_path)
        System.halt(1)
    end
    def filter_parser_output({:token_not_absorbed_error, _, token_list, error_cause}, source_code_path, _) do
        Helpers.ErrorDetecter.parser_error(:token_not_absorbed_error, token_list, error_cause, source_code_path)
        System.halt(1)
    end
    def filter_parser_output({_,output_abstract_syntax_tree,_,_}, _, verbose) do
        if verbose do
            Helpers.OASTPrinter.print(output_abstract_syntax_tree)
        end
        output_abstract_syntax_tree
    end
end