defmodule StageOneLexer do
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

  test "015_S2_Valid_Negative", context do
    gtl = Reader._generate_general_token_list(Helpers.Lt.get_c_tokens_content())
    scs = """
    int main() {
      return -7;
    }
    """
    new_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}
    #new_token2 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}
    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == {Helpers.Lt.update_otl(context[:otl], new_token), :ok}
    #assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == {Helpers.Lt.update_otl(context[:otl], new_token2), :ok}
  end

  test "016_S2_Valid_Bitwise", context dos
    gtl = Reader._generate_general_token_list(Helpers.Lt.get_c_tokens_content())
    scs = """
    int main() {
      return ~7;
    }
    """
    new_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, tag: "minus"}
    #new_token2 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}
    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == {Helpers.Lt.update_otl(context[:otl], new_token), :ok}
    #assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == {Helpers.Lt.update_otl(context[:otl], new_token2), :ok}
  end

end