defmodule StageOneParser do
  use ExUnit.Case

  setup_all do
      {:ok,
       [output_token_list:
        [
          %Structs.Token{expression: "int", pos_x: nil, pos_y: nil, tag: "int"},
          %Structs.Token{expression: "main", pos_x: nil, pos_y: nil, tag: "main"},
          %Structs.Token{
            expression: "(",
            pos_x: nil,
            pos_y: nil,
            tag: "parenthesis-open"
          },
          %Structs.Token{
            expression: ")",
            pos_x: nil,
            pos_y: nil,
            tag: "parenthesis-close"
          },
          %Structs.Token{expression: "{", pos_x: nil, pos_y: nil, tag: "bracket-open"},
          %Structs.Token{expression: "return", pos_x: nil, pos_y: nil, tag: "return"},
          %Structs.Token{expression: ";", pos_x: nil, pos_y: nil, tag: "semicolon"},
          %Structs.Token{expression: "}", pos_x: nil, pos_y: nil, tag: "bracket-close"}
        ]
      ]}
    end

  test "001_S1_Valid_Return0", context do
      general_token_list = Helpers.LexerTester.get_c_tokens_content()
      |> Reader._generate_general_token_list()
      source_code_string = """
      int main() {
        return 0;
      }
      """
      |> Reader._generate_source_code_string()
      otl = {source_code_string, general_token_list} |> Lexer.tokenize()
      ast = Helpers.ParserTester.get_c_structures_content()

      left_element = Parser.parse(otl, ast)

      new_token = %Structs.Token{expression: "0", pos_x: nil, pos_y: nil, tag: "literal"}
      token_list = [new_token]
      right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}
      assert left_element == "right_element"
  end

end