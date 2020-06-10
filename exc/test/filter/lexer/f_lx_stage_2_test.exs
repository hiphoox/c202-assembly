defmodule StageTwoFilterLexer do
  use ExUnit.Case
  # boilerplate code -> template
  setup_all do
      {:ok,
       [output_token_list:
        [
          %Structs.Token{expression: "int", pos_x: nil, pos_y: nil, tag: "int"},
          %Structs.Token{expression: "main", pos_x: nil, pos_y: nil,tag: "main"},
          %Structs.Token{expression: "(", pos_x: nil, pos_y: nil,
            tag: "parenthesis-open"},
          %Structs.Token{expression: ")", pos_x: nil, pos_y: nil, 
            tag: "parenthesis-close"},
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

  test "001_S2_Valid_Negative", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = 
    """
    int main(){
    return -7;
    }
    """
    |> Reader.clean_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, "", false)

    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, 
      tag: "minus"}
    literal_token = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    token_list = [minus_token, literal_token]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end
  
  test "002_S2_Valid_Bitwise", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = 
    """
    int main(){
    return ~7;
    }
    """
	  |> Reader.clean_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, "", false)

    complement_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, 
      tag: "complement"}
    literal_token = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    token_list = [complement_token, literal_token]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end
  
  test "003_S2_Valid_Bitwise_0", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = 
    """
    int main(){
    return ~0;
    }
    """
	  |> Reader.clean_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, "", false)

    complement_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, 
      tag: "complement"}
    literal_token = %Structs.Token{expression: "0", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    token_list = [complement_token, literal_token]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end
  
  test "004_S2_Valid_Not_7", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return !7;
    }
    """
    |> Reader.clean_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, "", false)

    negation_token = %Structs.Token{expression: "!", pos_x: nil, pos_y: nil, 
      tag: "negation"}
    literal_token = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    token_list = [negation_token, literal_token]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end
  
  test "005_S2_Valid_Not_0", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return !7;
    }
    """
    |> Reader.clean_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, "", false)

    complement_token = %Structs.Token{expression: "!", pos_x: nil, pos_y: nil, 
      tag: "negation"}
    literal_token = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    token_list = [complement_token, literal_token]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end
  
  test "006_S2_Valid_Multiple_Ops_1", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return -~7;
    }
    """
	  |> Reader.clean_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, "", false)

    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, 
      tag: "minus"}
    complement_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, 
      tag: "complement"}
    literal_token = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    token_list = [minus_token, complement_token, literal_token]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end
  
  test "007_S2_Valid_Multiple_Ops_2", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return !-4;
    }
    """
	|> Reader.clean_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, "", false)

    negation_token = %Structs.Token{expression: "!", pos_x: nil, pos_y: nil, 
      tag: "negation"}
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, 
      tag: "minus"}
    literal_token = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    token_list = [negation_token, minus_token, literal_token]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end
  
  test "008_S2_Valid_Multiple_Ops_3", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return !~0;
    }
    """
	  |> Reader.clean_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, "", false)

    negation_token = %Structs.Token{expression: "!", pos_x: nil, pos_y: nil, 
      tag: "negation"}
    complement_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, 
      tag: "complement"}
    literal_token = %Structs.Token{expression: "0", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    token_list = [negation_token, complement_token, literal_token]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end
  
  test "009_S2_Invalid_Wrong_Order_Negative", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return !~0;
    }
    """
	  |> Reader.clean_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, "", false)

    negation_token = %Structs.Token{expression: "!", pos_x: nil, pos_y: nil, 
      tag: "negation"}
    complement_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, 
      tag: "complement"}
    literal_token = %Structs.Token{expression: "0", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    token_list = [negation_token, complement_token, literal_token]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end
  
  test "010_S2_Invalid_Correct_Neg_Wrong_Bitwise_Order", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return -5~;
    }
    """
	  |> Reader.clean_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, "", false)

    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, 
      tag: "minus"}
    literal_token = %Structs.Token{expression: "5", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    complement_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, 
      tag: "complement"}
    
    token_list = [minus_token, literal_token, complement_token]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end
  
  test "011_S2_Invalid_Bitwise_No_Semicolon", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return 0
    }
    """
	  |> Reader.clean_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, "", false)

    literal_token = %Structs.Token{expression: "0", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    token_list = [literal_token]
    incomplete_output_token_list = GeneralTester.delete_token_from_otl(
      context[:output_token_list], 6)
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end
  
  test "012_S2_Invalid_Not_Missing_Const", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return !;
    }
    """
	  |> Reader.clean_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, "", false)

    negation_token = %Structs.Token{expression: "!", pos_x: nil, pos_y: nil, 
      tag: "negation"}
    
    token_list = [negation_token]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end
  
  test "013_S2_Invalid_Not_Bitwise_Const", context do
    test_path = "test/filter/lexer/f_lx_stage_1_test.exs"
    general_token_list =  GeneralTester.get_c_tokens_content() 
                          |> Reader._generate_general_token_list()
    source_code_string = """
    int main(){
    return !~;
    }
    """
    |> Reader.clean_source_code_string()
    left_hand_side =  Lexer.tokenize({source_code_string, general_token_list})
                      |> Filter.filter_lexer_output(test_path, "", false)

    negation_token = %Structs.Token{expression: "!", pos_x: nil, pos_y: nil, 
      tag: "negation"}
    complement_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, 
      tag: "complement"}
    
    token_list = [negation_token, complement_token]
    incomplete_output_token_list = context[:output_token_list]
    output_token_list = GeneralTester.insert_token_list(
      incomplete_output_token_list, token_list, 6)
    right_hand_side = output_token_list

    assert left_hand_side == right_hand_side
  end
end