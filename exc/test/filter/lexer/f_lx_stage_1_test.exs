defmodule StageOneFilterLexer do
  use ExUnit.Case

  # boilerplate code -> template
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
          # here goes the body of the program
          %Structs.Token{expression: ";", pos_x: nil, pos_y: nil, tag: "semicolon"},
          %Structs.Token{expression: "}", pos_x: nil, pos_y: nil, tag: "bracket-close"}
        ]
      ]}
    end

  test "001_S1_Valid_", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  Helpers.LexerTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main() {
      return;
    }
    """ |> Reader._generate_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, false)

    literal_token = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}
    token_list = [literal_token]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = Helpers.LexerTester.insert_token_list(incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end

end