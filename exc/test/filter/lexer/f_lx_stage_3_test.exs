defmodule StageThreeFilterLexer do
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
          %Structs.Token{expression: "{", pos_x: nil, pos_y: nil, 
            tag: "bracket-open"},
          %Structs.Token{expression: "return", pos_x: nil, pos_y: nil, 
            tag: "return"},
          # here goes the body of the program
          %Structs.Token{expression: ";", pos_x: nil, pos_y: nil, 
            tag: "semicolon"},
          %Structs.Token{expression: "}", pos_x: nil, pos_y: nil, 
            tag: "bracket-close"}
        ]
      ]}
    end

  test "001_S3_Valid_Add", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return 4 + 7;
    }
    """
	|> Reader._generate_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, false)

    literal_token1 = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    plus_token = %Structs.Token{expression: "+", pos_x: nil, pos_y: nil, 
      tag: "plus"}
    literal_token2= %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    token_list = [literal_token1, plus_token, literal_token2]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end
    
  test "002_S3_Valid_SubstractPositive", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return 4 - 17;
    }
    """
	  |> Reader._generate_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, false)

    literal_token1 = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, 
      tag: "minus"}
    literal_token2= %Structs.Token{expression: "17", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    token_list = [literal_token1, minus_token, literal_token2]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end

  test "003_S3_Valid_SubstractNegative", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return -7 - -8;
    }
    """
	  |> Reader._generate_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, false)

    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, 
      tag: "minus"}
    literal_token1 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    literal_token2= %Structs.Token{expression: "8", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    token_list = [minus_token, literal_token1, minus_token, minus_token, 
      literal_token2]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end

  test "004_S3_Valid_DivPositive", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return 18 / 3;
    }
    """
	  |> Reader._generate_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, false)

    literal_token1 = %Structs.Token{expression: "18", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    slant_token = %Structs.Token{expression: "/", pos_x: nil, pos_y: nil, 
      tag: "slant"}
    literal_token2= %Structs.Token{expression: "3", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    token_list = [literal_token1, slant_token, literal_token2]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end

  test "005_S3_Valid_DivNegative", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return -8 / -4;
    }
    """
	  |> Reader._generate_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, false)

    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, 
      tag: "minus"}
    literal_token1 = %Structs.Token{expression: "8", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    slant_token = %Structs.Token{expression: "/", pos_x: nil, pos_y: nil, 
      tag: "slant"}
    literal_token2= %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    token_list = [minus_token, literal_token1, slant_token, minus_token, 
      literal_token2]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end

  test "006_S3_Valid_MultPositive", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return 11 * 17;
    }
    """
	  |> Reader._generate_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, false)

    literal_token1 = %Structs.Token{expression: "11", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    asterix_token = %Structs.Token{expression: "*", pos_x: nil, pos_y: nil, 
      tag: "asterix"}
    literal_token2= %Structs.Token{expression: "17", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    token_list = [literal_token1, asterix_token, literal_token2]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end

  test "007_S3_Valid_MultNeg", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return 5 * -13;
    }
    """
	  |> Reader._generate_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, false)

    literal_token1 = %Structs.Token{expression: "5", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    asterix_token = %Structs.Token{expression: "*", pos_x: nil, pos_y: nil, 
      tag: "asterix"}
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, 
      tag: "minus"}
    literal_token2= %Structs.Token{expression: "13", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    token_list = [literal_token1, asterix_token, minus_token, literal_token2]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end

  test "008_S3_Valid_SimpleParenthesis", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return 2 * (5 + 3);
    }
    """
	  |> Reader._generate_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, false)

    literal_token1 = %Structs.Token{expression: "2", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    asterix_token = %Structs.Token{expression: "*", pos_x: nil, pos_y: nil, 
      tag: "asterix"}
    parenthesis_open_token = %Structs.Token{expression: "(", pos_x: nil, 
      pos_y: nil, tag: "parenthesis-open"}
    plus_token = %Structs.Token{expression: "+", pos_x: nil, pos_y: nil, 
      tag: "plus"}
    literal_token2= %Structs.Token{expression: "5", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    literal_token3= %Structs.Token{expression: "3", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    parenthesis_close_token = %Structs.Token{expression: ")", pos_x: nil, 
      pos_y: nil, tag: "parenthesis-close"}
    token_list = [literal_token1, asterix_token, parenthesis_open_token, 
      literal_token2, plus_token, literal_token3,
    parenthesis_close_token]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end

test "009_S3_Valid_Precedence", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return 2 * 5 + 21 / 9;
    }
    """
	  |> Reader._generate_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, false)

    literal_token1 = %Structs.Token{expression: "2", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    asterix_token = %Structs.Token{expression: "*", pos_x: nil, pos_y: nil, 
      tag: "asterix"}
    literal_token2 = %Structs.Token{expression: "5", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    plus_token = %Structs.Token{expression: "+", pos_x: nil, pos_y: nil, 
      tag: "plus"}
    literal_token3 = %Structs.Token{expression: "21", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    slant_token = %Structs.Token{expression: "/", pos_x: nil, pos_y: nil, 
      tag: "slant"}
    literal_token4 = %Structs.Token{expression: "9", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    
    token_list = [literal_token1, asterix_token, literal_token2, plus_token, 
    literal_token3, slant_token, literal_token4]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end

  test "010_S3_Valid_Bitwise_NoParenthesis", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return ~7 - 4;
    }
    """
	  |> Reader._generate_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, false)

    complement_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, 
      tag: "complement"}
    literal_token1 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, 
      tag: "minus"}
    literal_token2 = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    token_list = [complement_token, literal_token1, minus_token, literal_token2]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end

  test "011_S3_Valid_Bitwise_Parenthesis", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return ~(7 + 4);
    }
    """
	  |> Reader._generate_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, false)

    complement_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, 
      tag: "complement"}
    parenthesis_open_token = %Structs.Token{expression: "(", pos_x: nil, 
      pos_y: nil, tag: "parenthesis-open"}
    literal_token1 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    minus_token = %Structs.Token{expression: "+", pos_x: nil, pos_y: nil, 
      tag: "plus"}
    literal_token2 = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    parenthesis_close_token = %Structs.Token{expression: ")", pos_x: nil, 
      pos_y: nil, tag: "parenthesis-close"}
    token_list = [complement_token, parenthesis_open_token, literal_token1, 
    minus_token, literal_token2, parenthesis_close_token]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end

  test "012_S3_Invalid_Div_Missing_Operator", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return 3 / ;
    }
    """
    |> Reader._generate_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, false)

    literal_token1 = %Structs.Token{expression: "3", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    slant_token = %Structs.Token{expression: "/", pos_x: nil, pos_y: nil, tag: "slant"}
    
    token_list = [literal_token1, slant_token]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
        incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end

  test "013_S3_Invalid_Sum_Missing_Operator", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return 7 + ;
    }
    """
    |> Reader._generate_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, false)

    literal_token1 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    plus_token = %Structs.Token{expression: "+", pos_x: nil, pos_y: nil, 
      tag: "plus"}
    
    token_list = [literal_token1, plus_token]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
        incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end

  test "014_S3_Invalid_Parenthesis_Middle_Operator", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return (6 + 4) 10;
    }
    """
    |> Reader._generate_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, false)

    parenthesis_open_token = %Structs.Token{expression: "(", pos_x: nil, 
      pos_y: nil, tag: "parenthesis-open"}
    literal_token1 = %Structs.Token{expression: "6", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    plus_token = %Structs.Token{expression: "+", pos_x: nil, pos_y: nil, 
      tag: "plus"}
    literal_token2 = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    parenthesis_close_token = %Structs.Token{expression: ")", pos_x: nil, 
      pos_y: nil, tag: "parenthesis-close"}
    literal_token3 = %Structs.Token{expression: "10", pos_x: nil, pos_y: nil, 
      tag: "literal"}

    token_list = [parenthesis_open_token, literal_token1, plus_token, 
    literal_token2, parenthesis_close_token, literal_token3]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end

  test "015_S3_Invalid_Neg_Missing_Operator", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return (6 + 4) -;
    }
    """
    |> Reader._generate_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, false)

    parenthesis_open_token = %Structs.Token{expression: "(", pos_x: nil, 
      pos_y: nil, tag: "parenthesis-open"}
    literal_token1 = %Structs.Token{expression: "6", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    plus_token = %Structs.Token{expression: "+", pos_x: nil, pos_y: nil, tag: "plus"}
    literal_token2 = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    parenthesis_close_token = %Structs.Token{expression: ")", pos_x: nil, 
      pos_y: nil, tag: "parenthesis-close"}
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}

    token_list = [parenthesis_open_token, literal_token1, plus_token, 
    literal_token2, parenthesis_close_token, minus_token]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end

end