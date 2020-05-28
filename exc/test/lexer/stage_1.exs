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

    test "001_S1_Valid_Return0", context do
        general_token_list = Helpers.Lt.get_c_tokens_content()
        |> Reader._generate_general_token_list()
        source_code_string = """
        int main() {
          return 0;
        }
        """
        |> Reader._generate_source_code_string()
        left_element = {source_code_string, general_token_list} |> Lexer.tokenize()
        new_token = %Structs.Token{expression: "0", pos_x: nil, pos_y: nil, tag: "literal"}
        token_list = [new_token]
        right_element = {Helpers.Lt.insert_token_list(context[:output_token_list], token_list, 6), :ok}
        assert left_element == right_element
    end

    test "002_S1_Valid_Return7", context do
      general_token_list = Helpers.Lt.get_c_tokens_content()
      |> Reader._generate_general_token_list()
      source_code_string = """
      int main() {
       return 7;
      }
      """
      |> Reader._generate_source_code_string()
      left_element = {source_code_string, general_token_list} |> Lexer.tokenize()
      new_token = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}
      token_list = [new_token]
      right_element = {Helpers.Lt.insert_token_list(context[:output_token_list], token_list, 6), :ok}
      assert left_element == right_element
    end

    test "003_S1_Valid_ReturnMD130", context do
        gtl = Reader._generate_general_token_list(Helpers.Lt.get_c_tokens_content())
        scs = """
        int main() {
          return 130;
        }
        """
        new_token = %Structs.Token{expression: "130", pos_x: nil, pos_y: nil, tag: "literal"}
        assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == {Helpers.Lt.insert_token_list(context[:output_token_list], [new_token], 6), :ok}
    end
    
    test "004_S1_Valid_ReturnBlankSpaces", context do
      general_token_list = Helpers.Lt.get_c_tokens_content()
      |> Reader._generate_general_token_list()
      source_code_string = """
      int
      main
      (
      )
      {
      return
      1
      ; 
      }
      """
      |> Reader._generate_source_code_string()
      left_element = {source_code_string, general_token_list} |> Lexer.tokenize()
      new_token = %Structs.Token{expression: "1", pos_x: nil, pos_y: nil, tag: "literal"}
      token_list = [new_token]
      right_element = {Helpers.Lt.insert_token_list(context[:output_token_list], token_list, 6), :ok}
      assert left_element == right_element
    end

    test "005_S1_Valid_ReturnNoLineB", context do 
        gtl = Reader._generate_general_token_list(Helpers.Lt.get_c_tokens_content())
        scs = """
        int main(){return 1;}
        """
        new_token = %Structs.Token{expression: "1", pos_x: nil, pos_y: nil, tag: "literal"}
        assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == {Helpers.Lt.insert_token_list(context[:output_token_list], [new_token], 6), :ok}
    end

    test "006_S1_Valid_ReturnSpaceChars", context do 
        gtl = Reader._generate_general_token_list(Helpers.Lt.get_c_tokens_content())
        scs = """
        int	main    () 	{



          return       1 	 	 ;
          }
        """
        new_token = %Structs.Token{expression: "1", pos_x: nil, pos_y: nil, tag: "literal"}
        assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == {Helpers.Lt.insert_token_list(context[:output_token_list], [new_token], 6), :ok}
    end

    test "007_S1_Invalid_ReturnNull" do 
        gtl = Reader._generate_general_token_list(Helpers.Lt.get_c_tokens_content())
        scs = """
        int main() {
          return;
         }
        """
        new_token = %Structs.Token{expression: "return;", pos_x: nil, pos_y: nil, tag: "error"}
        assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == {new_token, :error}
    end

    test "011_S1_Invalid_ReturnNoSpaces" do 
        gtl = Reader._generate_general_token_list(Helpers.Lt.get_c_tokens_content())
        scs = """
        intmain() {
          return 44;
        }
        """ 
        tl = {scs |> Reader._generate_source_code_string(), gtl}
        new_token = %Structs.Token{expression: "intmain()", pos_x: nil, pos_y: nil, tag: "error"}
        assert Lexer.tokenize(tl) == {new_token, :error}
    end

    test "012_S1_Invalid_ReturnComma" do 
      gtl = Reader._generate_general_token_list(Helpers.Lt.get_c_tokens_content())
      scs = """
      int main() {
        return 2,
      }
      """
      new_token = %Structs.Token{expression: ",", pos_x: nil, pos_y: nil, tag: "error"}
      assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == {new_token, :error}
    end

    test "013_S1_Invalid_ReturnCaps" do
        gtl = Reader._generate_general_token_list(Helpers.Lt.get_c_tokens_content())
        scs = """
        Int main() {
          Return 2;
        }
        """
        new_token = %Structs.Token{expression: "Int", pos_x: nil, pos_y: nil, tag: "error"}
        assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == {new_token, :error}
    end

    test "014_S1_Valid_ReturnPrecZero", context do
      gtl = Reader._generate_general_token_list(Helpers.Lt.get_c_tokens_content())
      scs = """
      int main() {
        return 007;
      }
      """
      new_token = %Structs.Token{expression: "007", pos_x: nil, pos_y: nil, tag: "literal"}
      assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == {Helpers.Lt.insert_token_list(context[:output_token_list], [new_token], 6), :ok}
    end

    # test "015_S2_Valid_Negative", context do
    #   gtl = Reader._generate_general_token_list(Helpers.Lt.get_c_tokens_content())
    #   scs = """
    #   int main() {
    #     return -7;
    #   }
    #   """
    #   new_token = %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}
    #   #new_token2 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}
    #   assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == {Helpers.Lt.update_otl(context[:otl], new_token), :ok}
    #   #assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == {Helpers.Lt.update_otl(context[:otl], new_token2), :ok}
    # end

    # test "016_S2_Valid_Bitwise", context dos
    #   gtl = Reader._generate_general_token_list(Helpers.Lt.get_c_tokens_content())
    #   scs = """
    #   int main() {
    #     return ~7;
    #   }
    #   """
    #   new_token = %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, tag: "minus"}
    #   #new_token2 = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}
    #   assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == {Helpers.Lt.update_otl(context[:otl], new_token), :ok}
    #   #assert Lexer.tokenize({scs |> Reader._generate_source_code_string(), gtl}) == {Helpers.Lt.update_otl(context[:otl], new_token2), :ok}
    # end

end