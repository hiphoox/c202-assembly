defmodule StageTwoLexer do
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

  test "001_S2_Valid_Negative", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return -7;
    }
    """
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}
    literal_token = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [minus_token, literal_token]

    right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end

  test "002_S2_Valid_Bitwise", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return ~7;
    }
    """
    complement_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, tag: "complement"}
    literal_token = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [complement_token, literal_token]

    right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "003_S2_Valid_Bitwise_0", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return ~0;
    }
    """
    complement_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, tag: "complement"}
    literal_token = %Structs.Token{expression: "0", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [complement_token, literal_token]

    right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "004_S2_Valid_Not_7", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return !7;
    }
    """
    negation_token = %Structs.Token{expression: "!", pos_x: nil, pos_y: nil, tag: "negation"}
    literal_token = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [negation_token, literal_token]

    right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "005_S2_Valid_Not_0", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return !0;
    }
    """
    negation_token = %Structs.Token{expression: "!", pos_x: nil, pos_y: nil, tag: "negation"}
    literal_token = %Structs.Token{expression: "0", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [negation_token, literal_token]

    right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "006_S2_Valid_Multiple_Ops_1", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return -~0;
    }
    """
	minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}
	complement_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, tag: "complement"}
    literal_token = %Structs.Token{expression: "0", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [minus_token, complement_token, literal_token]

    right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "007_S2_Valid_Multiple_Ops_2", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return !-4;
    }
    """
    negation_token = %Structs.Token{expression: "!", pos_x: nil, pos_y: nil, tag: "negation"}
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}
    literal_token = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [negation_token, minus_token, literal_token]

    right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "008_S2_Valid_Multiple_Ops_3", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return !~4;
    }
    """
    negation_token = %Structs.Token{expression: "!", pos_x: nil, pos_y: nil, tag: "negation"}
    complement_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, tag: "complement"}
    literal_token = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [negation_token, complement_token, literal_token]

    right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end

	@doc """
	Even though the code of the following test should not compile, the lexer does not throw an error
	"""
	test "009_S2_Invalid_Wrong_Order_Negative", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return 7-;
    }
    """
    literal_token = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}

    token_list = [literal_token, minus_token]

    right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  @doc """
  Even though the code of the following test should not compile, the lexer does not throw an error
  """
  test "010_S2_Invalid_Correct_Neg_Wrong_Bitwise_Order", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return -5~;
    }
    """
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}
    literal_token = %Structs.Token{expression: "5", pos_x: nil, pos_y: nil, tag: "literal"}
	complement_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, tag: "complement"}    

    token_list = [minus_token, literal_token, complement_token]

    right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  @doc """
  Even though the code of the following test should not compile, the lexer does not throw an error
  """
  test "011_S2_Invalid_Bitwise_No_Semicolon", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return 0
    }
    """
    literal_token = %Structs.Token{expression: "0", pos_x: nil, pos_y: nil, tag: "literal"}
    
    temp_list = Helpers.LexerTester.update_otl(context[:output_token_list], 6)
    
    right_element = {Helpers.LexerTester.insert_token_list(temp_list, [literal_token], 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "012_S2_Invalid_Not_Missing_Const", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return !;
    }
    """
    negation_token = %Structs.Token{expression: "!", pos_x: nil, pos_y: nil, tag: "negation"}


    right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], [negation_token], 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
  test "013_S2_Invalid_Not_Bitwise_Const", context do
    gtl = Reader._generate_general_token_list(Helpers.LexerTester.get_c_tokens_content())
    scs = """
    int main() {
      return !~;
    }
    """
    negation_token = %Structs.Token{expression: "!", pos_x: nil, pos_y: nil, tag: "negation"}
	complement_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, tag: "complement"}    

    token_list = [negation_token, complement_token]

    right_element = {Helpers.LexerTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == right_element
  end
  
end