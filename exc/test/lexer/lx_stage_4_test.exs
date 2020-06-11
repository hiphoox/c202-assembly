defmodule StageFourLexer do
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
    source_code_string = """
    int main() {
      return 4 + 7;
    }
    """
    literal_token1 = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, tag: "literal"}
    plus_token = %Structs.Token{expression: "+", pos_x: nil, pos_y: nil, tag: "plus"}
    literal_token2 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}

    token_list = [literal_token1, plus_token, literal_token2]

    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end
  
  test "001_S4_Valid_AND_Boolean_False", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 7 && 4;
    }
    """
	  
    literal_token1= %Structs.Token{expression: "7", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token2 = %Structs.Token{expression: "4", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    and_token = %Structs.Token{expression: "&&", pos_x: nil, pos_y: nil, 
      tag: "and"}
    
    token_list = [literal_token1, and_token, literal_token2]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "002_S4_Valid_AND_Boolean_True", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 4 && -4;
    }
    """
	
    literal_token1= %Structs.Token{expression: "4", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    
    and_token = %Structs.Token{expression: "&&", pos_x: nil, pos_y: nil, 
      tag: "and"}
    minus_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}
    
    token_list = [literal_token1, and_token, minus_token, literal_token1]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "003_S4_Valid_GE_Relational_False", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 11 >= 21;
    }
    """
	
    literal_token1= %Structs.Token{expression: "11", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token2= %Structs.Token{expression: "21", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    
    geq_token = %Structs.Token{expression: ">=", pos_x: nil, pos_y: nil, 
      tag: "geq"}
    
    token_list = [literal_token1, geq_token, literal_token2]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "004_S4_Valid_GE_Relational_True", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 4 >= 3;
    }
    """
	
    literal_token1= %Structs.Token{expression: "4", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token2= %Structs.Token{expression: "3", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    
    geq_token = %Structs.Token{expression: ">=", pos_x: nil, pos_y: nil, 
      tag: "geq"}
    
    token_list = [literal_token1, geq_token, literal_token2]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end
    
  test "005_S4_Valid_EQ_Relational_False", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 7 == 13;
    }
    """
	
    literal_token1= %Structs.Token{expression: "7", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token2= %Structs.Token{expression: "13", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    
    eq_token = %Structs.Token{expression: "==", pos_x: nil, pos_y: nil, 
      tag: "eq"}
    
    token_list = [literal_token1, eq_token, literal_token2]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "006_S4_Valid_EQ_Relational_True", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 5 == 5;
    }
    """
	
    literal_token1= %Structs.Token{expression: "5", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    
    eq_token = %Structs.Token{expression: "==", pos_x: nil, pos_y: nil, 
      tag: "eq"}
    
    token_list = [literal_token1, eq_token, literal_token1]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "007_S4_Valid_GT_Relation_False", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 3 > 9;
    }
    """
	
    literal_token1= %Structs.Token{expression: "3", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token2= %Structs.Token{expression: "9", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    
    gt_token = %Structs.Token{expression: ">", pos_x: nil, pos_y: nil, 
      tag: "ge"}
    
    token_list = [literal_token1, gt_token, literal_token2]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "008_S4_Valid_GT_Relational_True", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 5 > 0;
    }
    """
	
    literal_token1= %Structs.Token{expression: "5", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token2= %Structs.Token{expression: "0", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    
    ge_token = %Structs.Token{expression: ">", pos_x: nil, pos_y: nil, 
      tag: "ge"}
    
    token_list = [literal_token1, ge_token, literal_token2]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "009_S4_Valid_LE_Relational_False", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 7 <= 6;
    }
    """
	
    literal_token1= %Structs.Token{expression: "7", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token2= %Structs.Token{expression: "6", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    
    leq_token = %Structs.Token{expression: "<=", pos_x: nil, pos_y: nil, 
      tag: "leq"}
    
    token_list = [literal_token1, leq_token, literal_token2]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "010_S4_Valid_LE_Relational_True", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 17 <= 17;
    }
    """
	
    literal_token1= %Structs.Token{expression: "17", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    
    leq_token = %Structs.Token{expression: "<=", pos_x: nil, pos_y: nil, 
      tag: "leq"}
    
    token_list = [literal_token1, leq_token, literal_token1]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "011_S4_Valid_LT_Relational_False", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 5 < 1;
    }
    """ 
	
    literal_token1= %Structs.Token{expression: "5", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token2= %Structs.Token{expression: "1", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    
    le_token = %Structs.Token{expression: "<", pos_x: nil, pos_y: nil, 
      tag: "le"}
    
    token_list = [literal_token1, le_token, literal_token2]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "012_S4_Valid_LT_Relational_True", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 5 < 11;
    }
    """ 
	
    literal_token1= %Structs.Token{expression: "5", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token2= %Structs.Token{expression: "11", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    
    le_token = %Structs.Token{expression: "<", pos_x: nil, pos_y: nil, 
      tag: "le"}
    
    token_list = [literal_token1, le_token, literal_token2]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "013_S4_Valid_NE_Relational_False", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 4 != 4;
    }
    """ 
	
    literal_token1= %Structs.Token{expression: "4", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    
    neq_token = %Structs.Token{expression: "!=", pos_x: nil, pos_y: nil, 
      tag: "neq"}
    
    token_list = [literal_token1, neq_token, literal_token1]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "014_S4_Valid_NE_Relational_True", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 7 != 4;
    }
    """ 
	
    literal_token1= %Structs.Token{expression: "7", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token2= %Structs.Token{expression: "4", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    
    neq_token = %Structs.Token{expression: "!=", pos_x: nil, pos_y: nil, 
      tag: "neq"}
    
    token_list = [literal_token1, neq_token, literal_token2]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "015_S4_Valid_OR_Boolean_False", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 4 || 4;
    }
    """ 
	
    
    literal_token1= %Structs.Token{expression: "4", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    
    or_token = %Structs.Token{expression: "||", pos_x: nil, pos_y: nil, 
      tag: "or"}
    
    token_list = [literal_token1, or_token, literal_token1]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "016_S4_Valid_OR_Boolean_True", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 4 || 0;
    }
    """ 
	
    
    literal_token1= %Structs.Token{expression: "4", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token2= %Structs.Token{expression: "0", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    
    or_token = %Structs.Token{expression: "||", pos_x: nil, pos_y: nil, 
      tag: "or"}
    
    token_list = [literal_token1, or_token, literal_token2]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "017_S4_Valid_Precedence", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 1 && 7 || 0;
    }
    """ 
	
    
    literal_token1= %Structs.Token{expression: "1", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token2= %Structs.Token{expression: "7", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token3= %Structs.Token{expression: "0", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    and_token = %Structs.Token{expression: "&&", pos_x: nil, pos_y: nil, 
      tag: "and"}
    or_token = %Structs.Token{expression: "||", pos_x: nil, pos_y: nil, 
      tag: "or"}
    
    token_list = [literal_token1, and_token, literal_token2, or_token, literal_token3]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "018_S4_Valid_Precedence", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 4 == 4 >= 1;
    }
    """ 
	
    
    literal_token1= %Structs.Token{expression: "4", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token2= %Structs.Token{expression: "1", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    eq_token = %Structs.Token{expression: "==", pos_x: nil, pos_y: nil, 
      tag: "eq"}
    geq_token = %Structs.Token{expression: ">=", pos_x: nil, pos_y: nil, 
      tag: "geq"}
    
    token_list = [literal_token1, eq_token, literal_token1, geq_token, literal_token2]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "019_S4_Valid_Precedence", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return (4 || 1) && 4;
    }
    """ 
	
    
    literal_token1= %Structs.Token{expression: "4", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token2= %Structs.Token{expression: "1", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    and_token = %Structs.Token{expression: "&&", pos_x: nil, pos_y: nil, 
      tag: "and"}
    or_token = %Structs.Token{expression: "||", pos_x: nil, pos_y: nil, 
      tag: "or"}
    parenthesis_open_token = %Structs.Token{expression: "(", pos_x: nil, 
      pos_y: nil, tag: "parenthesis-open"}
    parenthesis_close_token = %Structs.Token{expression: ")", pos_x: nil, 
      pos_y: nil, tag: "parenthesis-close"}
    
    token_list = [parenthesis_open_token,literal_token1, or_token, literal_token2,
    parenthesis_close_token, and_token, literal_token1]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "020_S4_Valid_Precedence", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 1 && 4 || 1;
    }
    """ 
	
    literal_token1= %Structs.Token{expression: "1", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token2= %Structs.Token{expression: "4", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    and_token = %Structs.Token{expression: "&&", pos_x: nil, pos_y: nil, 
      tag: "and"}
    or_token = %Structs.Token{expression: "||", pos_x: nil, pos_y: nil, 
      tag: "or"}
    
    token_list = [literal_token1, and_token, literal_token2, or_token, literal_token1]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "021_S4_Valid_Precedence", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return (4 || 1) >= 2;
    }
    """ 
	
    
    literal_token1= %Structs.Token{expression: "4", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token2= %Structs.Token{expression: "1", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token3= %Structs.Token{expression: "2", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    geq_token = %Structs.Token{expression: ">=", pos_x: nil, pos_y: nil, 
      tag: "geq"}
    or_token = %Structs.Token{expression: "||", pos_x: nil, pos_y: nil, 
      tag: "or"}
    parenthesis_open_token = %Structs.Token{expression: "(", pos_x: nil, 
      pos_y: nil, tag: "parenthesis-open"}
    parenthesis_close_token = %Structs.Token{expression: ")", pos_x: nil, 
      pos_y: nil, tag: "parenthesis-close"}
    
    token_list = [parenthesis_open_token,literal_token1, or_token, literal_token2,
    parenthesis_close_token, geq_token, literal_token3]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "022_S4_Invalid_AND_First_Op_Missing", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return && 4;
    }
    """
    
    literal_token1= %Structs.Token{expression: "4", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    and_token = %Structs.Token{expression: "&&", pos_x: nil, pos_y: nil, 
      tag: "and"}
    
    token_list = [and_token, literal_token1]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "023_S4_Invalid_OR_Second_Op_Missing", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 4 ||;
    }
    """
    
    literal_token1= %Structs.Token{expression: "4", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    or_token = %Structs.Token{expression: "||", pos_x: nil, pos_y: nil, 
      tag: "or"}
    
    token_list = [literal_token1, or_token]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "024_S4_Invalid_Mid_Op_Missing", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 4 < < 9;
    }
    """
    
    literal_token1= %Structs.Token{expression: "4", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token2= %Structs.Token{expression: "9", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    le_token = %Structs.Token{expression: "<", pos_x: nil, pos_y: nil, 
      tag: "le"}
    
    token_list = [literal_token1, le_token, le_token, literal_token2]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "025_S4_Invalid_Semicolon", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
      return 1 <= 4
    }
    """
    
    literal_token1= %Structs.Token{expression: "1", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    literal_token2= %Structs.Token{expression: "4", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    
    leq_token = %Structs.Token{expression: "<=", pos_x: nil, pos_y: nil, 
      tag: "leq"}
    
    token_list = [literal_token1, leq_token, literal_token2]

    temp_list = GeneralTester.delete_token_from_otl(context[:output_token_list], 6)
    
    right_element = {GeneralTester.insert_token_list(temp_list, token_list, 6), :ok}

    assert Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end

  test "026_S4_Invalid_Return_Token_Not_Absorbed", context do
    gtl = Reader._generate_general_token_list(
      GeneralTester.get_c_tokens_content()
    )
    
    source_code_string = """
    int main(){
    return 4; return 7
    }
    """
    
    literal_token1= %Structs.Token{expression: "4", pos_x: nil, pos_y: nil,   
      tag: "literal"}
    
    literal_token2 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil,   
      tag: "literal"}

    return_token = %Structs.Token{expression: "return", pos_x: nil, pos_y: nil, 
            tag: "return"}
    
    token_list = [literal_token1, return_token, literal_token2]
    right_element = {GeneralTester.insert_token_list(context[:output_token_list], token_list, 6), :ok}

    refute Lexer.tokenize({source_code_string |> Reader.clean_source_code_string(), gtl}) == right_element
  end
  
end