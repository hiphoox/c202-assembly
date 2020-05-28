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
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}
    literal_token = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [minus_token, literal_token]

    right_element = {Helpers.Lt.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end

  test "016_S2_Valid_Bitwise", context do
    gtl = Reader._generate_general_token_list(Helpers.Lt.get_c_tokens_content())
    scs = """
    int main() {
      return ~7;
    }
    """
    complement_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, tag: "complement"}
    literal_token = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [complement_token, literal_token]

    right_element = {Helpers.Lt.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end

end