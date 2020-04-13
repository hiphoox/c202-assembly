defmodule Filter do 
    def filter_lexer_output({otl, :error}, source_code_path, _) do 
        Hps.ErrorDetecter.lexer_error(otl, source_code_path)
        System.halt(1)
    end
    def filter_lexer_output({otl, :ok}, _, verbose) do
        if verbose do
            #TODO: print otl
        end
        {otl, :ok}
    end

    def filter_parser_output({:token_missing_error, _, tl, error_cause}, file_path, _) do
        Hps.ErrorDetecter.parser_error(:token_missing_error, tl, error_cause, file_path)
        System.halt(1)
    end
    def filter_parser_output({:token_not_absorbed_error, _, tl, error_cause}, file_path, _) do
        Hps.ErrorDetecter.parser_error(:token_not_absorbed_error, tl, error_cause, file_path)
        System.halt(1)
    end
    def filter_parser_output({_,oast,_,_}, _, verbose) do
        Hps.OASTPrinter.print(oast, verbose)
        oast
    end
end