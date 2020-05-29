defmodule StageThreeLexer do
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

  test "001_S3_Valid_Add", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return 4 + 7;
    }
    """
    literal_token1 = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, tag: "literal"}
    plus_token = %Structs.Token{expression: "+", pos_x: nil, pos_y: nil, tag: "plus"}
    literal_token2 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [literal_token1, plus_token, literal_token2]

    right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "002_S3_Valid_SubstractPositive", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return 4 - 17;
    }
    """
    literal_token1 = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, tag: "literal"}
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}
    literal_token2 = %Structs.Token{expression: "17", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [literal_token1, minus_token, literal_token2]

    right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "003_S3_Valid_SubstractNegative", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return -7 - -8;
    }
    """
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}
    literal_token1 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}
    literal_token2 = %Structs.Token{expression: "8", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [minus_token, literal_token1, minus_token, minus_token, literal_token2]

    right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end

	test "004_S3_Valid_DivPositive", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return 18 / 3;
    }
    """
    literal_token1 = %Structs.Token{expression: "18", pos_x: nil, pos_y: nil, tag: "literal"}
    slant_token = %Structs.Token{expression: "/", pos_x: nil, pos_y: nil, tag: "slant"}
    literal_token2 = %Structs.Token{expression: "3", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [literal_token1, slant_token, literal_token2]

    right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "005_S3_Valid_DivNegative", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return -8 / -4;
    }
    """
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}
    literal_token1 = %Structs.Token{expression: "8", pos_x: nil, pos_y: nil, tag: "literal"}
    slant_token = %Structs.Token{expression: "/", pos_x: nil, pos_y: nil, tag: "slant"}
    literal_token2 = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [minus_token, literal_token1, slant_token, minus_token, literal_token2]

    right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end

	test "006_S3_Valid_MultPositive", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return 11 * 17;
    }
    """
    literal_token1 = %Structs.Token{expression: "11", pos_x: nil, pos_y: nil, tag: "literal"}
    asterix_token = %Structs.Token{expression: "*", pos_x: nil, pos_y: nil, tag: "asterix"}
    literal_token2 = %Structs.Token{expression: "17", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [literal_token1, asterix_token, literal_token2]

    right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "007_S3_Valid_MultNeg", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return 5 * -13;
    }
    """
    literal_token1 = %Structs.Token{expression: "5", pos_x: nil, pos_y: nil, tag: "literal"}
    asterix_token = %Structs.Token{expression: "*", pos_x: nil, pos_y: nil, tag: "asterix"}
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}
    literal_token2 = %Structs.Token{expression: "13", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [literal_token1, asterix_token, minus_token, literal_token2]

    right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  # test "008_S3_Valid_Parenthesis", context do
  #   gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
  #   scs = """
  #   int main() {
  #     return 7 * (5 * (8 - 5));
  #   }
  #   """
  #   literal_token1 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}
  #   asterix_token = %Structs.Token{expression: "*", pos_x: nil, pos_y: nil, tag: "asterix"}
  #   literal_token2 = %Structs.Token{expression: "5", pos_x: nil, pos_y: nil, tag: "literal"}
  #   minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}
  #   literal_token3 = %Structs.Token{expression: "13", pos_x: nil, pos_y: nil, tag: "literal"}

  #   token_list = [literal_token1, asterix_token, minus_token, literal_token2]

  #   right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

  #   assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  # end
		
end