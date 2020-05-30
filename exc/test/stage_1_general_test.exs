defmodule StageOneGeneral do 
    use ExUnit.Case

    test "000" do 
        general_abstract_syntax_tree =  Helpers.GeneralTester.get_c_structures_content()
                                    |> Reader._generate_general_ast()
        general_token_list = Helpers.GeneralTester.get_c_tokens_content()
        |> Reader._generate_general_token_list()
        source_code_string = """
        int main() {
          return 23;
        }
        """
        |> Reader._generate_source_code_string()
        verbose = false
        Lexer.tokenize({source_code_string, general_token_list})
        |> Filter.filter_lexer_output("", verbose)
        |> Parser.parse(general_abstract_syntax_tree)
        |> Filter.filter_parser_output("", verbose)
        |> CodeGenerator.generate_code(verbose)
        |> Writer.write_file()
        |> Invoker.invoke_gcc("")

        exc_output = Invoker.invoke_test_output()

        assert exc_output == '23\n'

    end
end
