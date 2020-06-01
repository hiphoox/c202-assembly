defmodule StageThreeLexer do
  use ExUnit.Case

  setup_all do
      {:ok,
       [output_token_list:
        [
          %Structs.Token{
            expression: "int", 
            pos_x: nil, 
            pos_y: nil, 
            tag: "int"
          },
          %Structs.Token{
            expression: "main", 
            pos_x: nil, 
            pos_y: nil, 
            tag: "main"
          },
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
          %Structs.Token{
            expression: "{", 
            pos_x: nil, 
            pos_y: nil, 
            tag: "bracket-open"
          },
          %Structs.Token{
            expression: "return", 
            pos_x: nil, 
            pos_y: nil, 
            tag: "return"
          },
          %Structs.Token{
            expression: ";", 
            pos_x: nil, 
            pos_y: nil, 
            tag: "semicolon"
          },
          %Structs.Token{
            expression: "}", 
            pos_x: nil, 
            pos_y: nil, 
            tag: "bracket-close"
          }
        ]
      ]}
    end

  test "001_S3_Valid_Add", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    scs = """
    int main() {
      return 4 + 7;
    }
    """
    literal_token1 = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, tag: "literal"}
    plus_token = %Structs.Token{expression: "+", pos_x: nil, pos_y: nil, tag: "plus"}
    literal_token2 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [literal_token1, plus_token, literal_token2]

    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "002_S3_Valid_SubstractPositive", context do
    gtl = Reader._generate_general_token_list(GeneralTester.get_c_tokens_content())
    scs = """
    int main() {
      return 4 - 17;
    }
    """
    literal_token1 = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, tag: "literal"}
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}
    literal_token2 = %Structs.Token{expression: "17", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [literal_token1, minus_token, literal_token2]

    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "003_S3_Valid_SubstractNegative", context do
    gtl = Reader._generate_general_token_list(GeneralTester.get_c_tokens_content())
    scs = """
    int main() {
      return -7 - -8;
    }
    """
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}
    literal_token1 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}
    literal_token2 = %Structs.Token{expression: "8", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [minus_token, literal_token1, minus_token, minus_token, literal_token2]

    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end

	test "004_S3_Valid_DivPositive", context do
    gtl = Reader._generate_general_token_list(GeneralTester.get_c_tokens_content())
    scs = """
    int main() {
      return 18 / 3;
    }
    """
    literal_token1 = %Structs.Token{expression: "18", pos_x: nil, pos_y: nil, tag: "literal"}
    slant_token = %Structs.Token{expression: "/", pos_x: nil, pos_y: nil, tag: "slant"}
    literal_token2 = %Structs.Token{expression: "3", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [literal_token1, slant_token, literal_token2]

    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "005_S3_Valid_DivNegative", context do
    gtl = Reader._generate_general_token_list(GeneralTester.get_c_tokens_content())
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

    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end

	test "006_S3_Valid_MultPositive", context do
    gtl = Reader._generate_general_token_list(GeneralTester.get_c_tokens_content())
    scs = """
    int main() {
      return 11 * 17;
    }
    """
    literal_token1 = %Structs.Token{expression: "11", pos_x: nil, pos_y: nil, tag: "literal"}
    asterix_token = %Structs.Token{expression: "*", pos_x: nil, pos_y: nil, tag: "asterix"}
    literal_token2 = %Structs.Token{expression: "17", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [literal_token1, asterix_token, literal_token2]

    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "007_S3_Valid_MultNeg", context do
    gtl = Reader._generate_general_token_list(GeneralTester.get_c_tokens_content())
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

    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "008_S3_Valid_Parenthesis", context do
    gtl = Reader._generate_general_token_list(GeneralTester.get_c_tokens_content())
    scs = """
    int main() {
      return 7 * (5 * (8 - 5));
    }
    """
    literal_token1 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}
    asterix_token = %Structs.Token{expression: "*", pos_x: nil, pos_y: nil, tag: "asterix"}
    parenthesis_open_token = %Structs.Token{expression: "(", pos_x: nil, pos_y: nil, tag: "parenthesis-open"}
    literal_token2 = %Structs.Token{expression: "5", pos_x: nil, pos_y: nil, tag: "literal"}
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}
    literal_token3 = %Structs.Token{expression: "8", pos_x: nil, pos_y: nil, tag: "literal"}
    parenthesis_close_token = %Structs.Token{expression: ")", pos_x: nil, pos_y: nil, tag: "parenthesis-close"}

    token_list = [literal_token1, asterix_token, parenthesis_open_token, literal_token2, asterix_token, parenthesis_open_token, literal_token3, minus_token, literal_token2, parenthesis_close_token, parenthesis_close_token]

    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "009_S3_Valid_SimpleParenthesis", context do
    gtl = Reader._generate_general_token_list(GeneralTester.get_c_tokens_content())
    scs = """
    int main() {
      return 2 * (5 + 3);
    }
    """
    literal_token1 = %Structs.Token{expression: "2", pos_x: nil, pos_y: nil, tag: "literal"}
    asterix_token = %Structs.Token{expression: "*", pos_x: nil, pos_y: nil, tag: "asterix"}
    parenthesis_open_token = %Structs.Token{expression: "(", pos_x: nil, pos_y: nil, tag: "parenthesis-open"}
    literal_token2 = %Structs.Token{expression: "5", pos_x: nil, pos_y: nil, tag: "literal"}
    plus_token = %Structs.Token{expression: "+", pos_x: nil, pos_y: nil, tag: "plus"}
    literal_token3 = %Structs.Token{expression: "3", pos_x: nil, pos_y: nil, tag: "literal"}
    parenthesis_close_token = %Structs.Token{expression: ")", pos_x: nil, pos_y: nil, tag: "parenthesis-close"}

    token_list = [literal_token1, asterix_token, parenthesis_open_token, literal_token2, plus_token, literal_token3, parenthesis_close_token]

    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "010_S3_Valid_Precedence", context do
    gtl = Reader._generate_general_token_list(GeneralTester.get_c_tokens_content())
    scs = """
    int main() {
      return 2 * 5 + 21 / 9;
    }
    """
    literal_token1 = %Structs.Token{expression: "2", pos_x: nil, pos_y: nil, tag: "literal"}
    asterix_token = %Structs.Token{expression: "*", pos_x: nil, pos_y: nil, tag: "asterix"}
    literal_token2 = %Structs.Token{expression: "5", pos_x: nil, pos_y: nil, tag: "literal"}
    plus_token = %Structs.Token{expression: "+", pos_x: nil, pos_y: nil, tag: "plus"}
    literal_token3 = %Structs.Token{expression: "21", pos_x: nil, pos_y: nil, tag: "literal"}
    slant_token = %Structs.Token{expression: "/", pos_x: nil, pos_y: nil, tag: "slant"}
    literal_token4 = %Structs.Token{expression: "9", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [literal_token1, asterix_token, literal_token2, plus_token, literal_token3, slant_token, literal_token4]

    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "011_S3_Valid_Bitwise_NoParenthesis", context do
    gtl = Reader._generate_general_token_list(GeneralTester.get_c_tokens_content())
    scs = """
    int main() {
      return ~7 - 4;
    }
    """
    complement_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, tag: "complement"}
    literal_token1 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}
    literal_token2 = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [complement_token, literal_token1, minus_token, literal_token2]

    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
	
	test "012_S3_Valid_BItwise_Parenthesis", context do
    gtl = Reader._generate_general_token_list(GeneralTester.get_c_tokens_content())
    scs = """
    int main() {
      return ~(7 + 4);
    }
    """
    complement_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, tag: "complement"}
    parenthesis_open_token = %Structs.Token{expression: "(", pos_x: nil, pos_y: nil, tag: "parenthesis-open"}
    literal_token1 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}
    plus_token = %Structs.Token{expression: "+", pos_x: nil, pos_y: nil, tag: "plus"}
    literal_token2 = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, tag: "literal"}
     parenthesis_close_token = %Structs.Token{expression: ")", pos_x: nil, pos_y: nil, tag: "parenthesis-close"}

    token_list = [complement_token, parenthesis_open_token, literal_token1, plus_token, literal_token2, parenthesis_close_token]

    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "013_S3_Valid_Multiple Parenthesis", context do
    gtl = Reader._generate_general_token_list(GeneralTester.get_c_tokens_content())
    scs = """
    int main() {
      return ~((7 + 4) / (8 * (5 - 3)));
    }
    """
    complement_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, tag: "complement"}
    parenthesis_open_token = %Structs.Token{expression: "(", pos_x: nil, pos_y: nil, tag: "parenthesis-open"}
    literal_token1 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}
    plus_token = %Structs.Token{expression: "+", pos_x: nil, pos_y: nil, tag: "plus"}
    literal_token2 = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, tag: "literal"}
    slant_token = %Structs.Token{expression: "/", pos_x: nil, pos_y: nil, tag: "slant"}
    literal_token3 = %Structs.Token{expression: "8", pos_x: nil, pos_y: nil, tag: "literal"}
    asterix_token = %Structs.Token{expression: "*", pos_x: nil, pos_y: nil, tag: "asterix"}
    literal_token4 = %Structs.Token{expression: "5", pos_x: nil, pos_y: nil, tag: "literal"}
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}
    literal_token5 = %Structs.Token{expression: "3", pos_x: nil, pos_y: nil, tag: "literal"}
     parenthesis_close_token = %Structs.Token{expression: ")", pos_x: nil, pos_y: nil, tag: "parenthesis-close"}

    token_list = [complement_token, parenthesis_open_token, parenthesis_open_token, literal_token1, plus_token, literal_token2, parenthesis_close_token, slant_token, parenthesis_open_token, literal_token3, asterix_token, parenthesis_open_token, literal_token4, minus_token, literal_token5, parenthesis_close_token, parenthesis_close_token, parenthesis_close_token]

    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "014_S3_Invalid_Div_Missing_Operator", context do
    gtl = Reader._generate_general_token_list(GeneralTester.get_c_tokens_content())
    scs = """
    int main() {
      return 3 / ;
    }
    """
    literal_token1 = %Structs.Token{expression: "3", pos_x: nil, pos_y: nil, tag: "literal"}
    slant_token = %Structs.Token{expression: "/", pos_x: nil, pos_y: nil, tag: "slant"}

    token_list = [literal_token1, slant_token]

    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "015_S3_Invalid_Sum_Missing_Operator", context do
    gtl = Reader._generate_general_token_list(GeneralTester.get_c_tokens_content())
    scs = """
    int main() {
      return 7 + ;
    }
    """
    literal_token1 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}
    plus_token = %Structs.Token{expression: "+", pos_x: nil, pos_y: nil, tag: "plus"}

    token_list = [literal_token1, plus_token]

    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "016_S3_Invalid_Parenthesis_Middle_Operator", context do
    gtl = Reader._generate_general_token_list(GeneralTester.get_c_tokens_content())
    scs = """
    int main() {
      return (6 + 4) 10;
    }
    """
    parenthesis_open_token = %Structs.Token{expression: "(", pos_x: nil, pos_y: nil, tag: "parenthesis-open"}
    literal_token1 = %Structs.Token{expression: "6", pos_x: nil, pos_y: nil, tag: "literal"}
    plus_token = %Structs.Token{expression: "+", pos_x: nil, pos_y: nil, tag: "plus"}
    literal_token2 = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, tag: "literal"}
    parenthesis_close_token = %Structs.Token{expression: ")", pos_x: nil, pos_y: nil, tag: "parenthesis-close"}
    literal_token3 = %Structs.Token{expression: "10", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [parenthesis_open_token, literal_token1, plus_token, literal_token2, parenthesis_close_token, literal_token3]

    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "017_S3_Invalid_Neg_Missing_Operator", context do
    gtl = Reader._generate_general_token_list(GeneralTester.get_c_tokens_content())
    scs = """
    int main() {
      return (6 + 4) -;
    }
    """
    parenthesis_open_token = %Structs.Token{expression: "(", pos_x: nil, pos_y: nil, tag: "parenthesis-open"}
    literal_token1 = %Structs.Token{expression: "6", pos_x: nil, pos_y: nil, tag: "literal"}
    plus_token = %Structs.Token{expression: "+", pos_x: nil, pos_y: nil, tag: "plus"}
    literal_token2 = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, tag: "literal"}
    parenthesis_close_token = %Structs.Token{expression: ")", pos_x: nil, pos_y: nil, tag: "parenthesis-close"}
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}

    token_list = [parenthesis_open_token, literal_token1, plus_token, literal_token2, parenthesis_close_token, minus_token]

    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "018_S3_Invalid_Missing_Parenthesis", context do
    gtl = Reader._generate_general_token_list(GeneralTester.get_c_tokens_content())
    scs = """
    int main() {
      return ((6 + 4) / 2;
    }
    """
    parenthesis_open_token = %Structs.Token{expression: "(", pos_x: nil, pos_y: nil, tag: "parenthesis-open"}
    literal_token1 = %Structs.Token{expression: "6", pos_x: nil, pos_y: nil, tag: "literal"}
    plus_token = %Structs.Token{expression: "+", pos_x: nil, pos_y: nil, tag: "plus"}
    literal_token2 = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, tag: "literal"}
    parenthesis_close_token = %Structs.Token{expression: ")", pos_x: nil, pos_y: nil, tag: "parenthesis-close"}
    slant_token = %Structs.Token{expression: "/", pos_x: nil, pos_y: nil, tag: "slant"}
    literal_token3 = %Structs.Token{expression: "2", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [parenthesis_open_token, parenthesis_open_token, literal_token1, plus_token, literal_token2, parenthesis_close_token, slant_token, literal_token3]

    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
end