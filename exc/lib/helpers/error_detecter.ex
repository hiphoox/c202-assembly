defmodule Helpers.ErrorDetecter do
    @moduledoc false

    def lexer_error(token, file_path) do
        class_msg = "** (Lexer Error) invalid token"
        fault_element_msg = "#{token.expression}"
        reason_msg  = ""
        location_msg = "#{file_path}"

        Helpers.Printer._print_error(class_msg, fault_element_msg, reason_msg, location_msg)
    end

    def parser_error(:token_missing_error, _, error_cause, file_path) do
        
        class_msg = "** (Parser Error) structure"
        fault_element = error_cause.tag
        reason_msg = "is missing something"
        location = file_path

        Helpers.Printer._print_error(class_msg, fault_element, reason_msg, location)
    end
    def parser_error(:token_not_absorbed_error, tl, _, file_path) do
        class_msg = "** (Parser Error) token"
        fault_element = Enum.at(tl, 0).expression
        reason_msg = "was not accepted"
        location = file_path

        Helpers.Printer._print_error(class_msg, fault_element, reason_msg, location)
    end

end