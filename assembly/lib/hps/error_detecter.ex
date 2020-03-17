defmodule Hps.ErrorDetecter do

    @reset "\u001B[0m"
    @red "\u001B[31m"
    # @purple "\u001B[35m"
    # @black "\u001B[30m"
    @bold "\u001B[1m"

    def generate_error(token, file_path) do
        IO.puts(@red <> "** (Lexer Error) invalid token \'" <> @bold <>  @red <> "#{token.expression}" <> @reset <> @red <> "\' in file #{file_path}" <> @reset)
        System.halt(0)
    end
end