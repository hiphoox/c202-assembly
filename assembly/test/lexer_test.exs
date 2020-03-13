defmodule LexerTest do
    use ExUnit.Case
    doctest Lexer

    setup_all do
        {:ok,
         [otl: 
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
          %Structs.Token{expression: "2", pos_x: nil, pos_y: nil, tag: "literal"},
          %Structs.Token{expression: ";", pos_x: nil, pos_y: nil, tag: "semicolon"},
          %Structs.Token{expression: "}", pos_x: nil, pos_y: nil, tag: "bracket-close"}
        ]
        ]}
      end

    test "001_S1_Valid_Return0", context do
        gtl = Reader.generate_gtl(Hps.Lt.get_gtl_content())
        scs = """
        int main() {
          return 0;
        }
        """
        new_token = %Structs.Token{expression: "0", pos_x: nil, pos_y: nil, tag: "literal"}
        assert Lexer.tokenize({scs |> Reader.generate_scs(), gtl, ""}) == Hps.Lt.update_otl(context[:otl], new_token)
    end

    test "002_S1_Valid_Return7", context do
        gtl = Reader.generate_gtl(Hps.Lt.get_gtl_content())
        scs = """
        int main() {
          return 7;
        }
        """
        new_token = %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}
        assert Lexer.tokenize({scs |> Reader.generate_scs(), gtl, ""}) == Hps.Lt.update_otl(context[:otl], new_token)
    end

    test "003_S1_Valid_ReturnMD130", context do
        gtl = Reader.generate_gtl(Hps.Lt.get_gtl_content())
        scs = """
        int main() {
          return 130;
        }
        """
        new_token = %Structs.Token{expression: "130", pos_x: nil, pos_y: nil, tag: "literal"}
        assert Lexer.tokenize({scs |> Reader.generate_scs(), gtl, ""}) == Hps.Lt.update_otl(context[:otl], new_token)
    end
    
    test "004_S1_Valid_ReturnBlankSpaces", context do 
        gtl = Reader.generate_gtl(Hps.Lt.get_gtl_content())
        scs = """
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
        new_token = %Structs.Token{expression: "1", pos_x: nil, pos_y: nil, tag: "literal"}
        assert Lexer.tokenize({scs |> Reader.generate_scs(), gtl, ""}) == Hps.Lt.update_otl(context[:otl], new_token)
    end

    test "005_S1_Valid_ReturnNoLineB", context do 
        gtl = Reader.generate_gtl(Hps.Lt.get_gtl_content())
        scs = """
        int main(){return 1;}
        """
        new_token = %Structs.Token{expression: "1", pos_x: nil, pos_y: nil, tag: "literal"}
        assert Lexer.tokenize({scs |> Reader.generate_scs(), gtl, ""}) == Hps.Lt.update_otl(context[:otl], new_token)
    end

    test "006_S1_Valid_ReturnSpaceChars", context do 
        gtl = Reader.generate_gtl(Hps.Lt.get_gtl_content())
        scs = """
        int	main    () 	{



          return       1 	 	 ;
          }
        """
        new_token = %Structs.Token{expression: "1", pos_x: nil, pos_y: nil, tag: "literal"}
        assert Lexer.tokenize({scs |> Reader.generate_scs(), gtl, ""}) == Hps.Lt.update_otl(context[:otl], new_token)
    end

    test "007_S1_Invalid_ReturnNull" do 
        gtl = Reader.generate_gtl(Hps.Lt.get_gtl_content())
        scs = """
        int main() {
          return;
         }
        """
        assert Lexer.tokenize({scs |> Reader.generate_scs(), gtl, ""}) == :error_token_not_present
    end

    test "008_S1_Invalid_ReturnNoFuncName" do
        gtl = Reader.generate_gtl(Hps.Lt.get_gtl_content())
        scs = """
        int () {
          return 1;
        }
        """
        assert Lexer.tokenize({scs |> Reader.generate_scs(), gtl, ""}) == :error_token_not_present
    end

    test "009_S1_Invalid_ReturnNoParenth" do
      gtl = Reader.generate_gtl(Hps.Lt.get_gtl_content())
      scs = """
      int main) {
        return 1;
      }
      """
      assert Lexer.tokenize({scs |> Reader.generate_scs(), gtl, ""}) == :error_token_not_present
    end

    test "010_S1_Invalid_ReturnNoBrack" do
      gtl = Reader.generate_gtl(Hps.Lt.get_gtl_content())
      scs = """
      int main() 
        return 13;
      }
      """
      assert Lexer.tokenize({scs |> Reader.generate_scs(), gtl, ""}) == :error_token_not_present
    end

    test "011_S1_Invalid_ReturnNoSpaces" do 
        gtl = Reader.generate_gtl(Hps.Lt.get_gtl_content())
        scs = """
        intmain() {
          return 44;
        }
        """
        assert Lexer.tokenize({scs |> Reader.generate_scs(), gtl, ""}) == :error_token_not_present
    end

    test "012_S1_Invalid_ReturnComma", context do 
      gtl = Reader.generate_gtl(Hps.Lt.get_gtl_content())
      scs = """
      int main() {
        return 2,
      }
      """
      new_token = %Structs.Token{expression: ",", pos_x: nil, pos_y: nil, tag: "error"}
      assert Lexer.tokenize({scs |> Reader.generate_scs(), gtl, ""}) == Hps.Lt.update_otl(context[:otl], new_token, 7)
    end

    test "013_S1_Invalid_ReturnCaps", context do
        gtl = Reader.generate_gtl(Hps.Lt.get_gtl_content())
        scs = """
        Int main() {
          Return 2;
        }
        """
        token1 = %Structs.Token{expression: "Int", pos_x: nil, pos_y: nil, tag: "error"}
        token2 = %Structs.Token{expression: "Return", pos_x: nil, pos_y: nil, tag: "error"}
        nl = Hps.Lt.update_otl(context[:otl], token1, 0)
        new_list = Hps.Lt.update_otl(nl, token2, 5)
        assert Lexer.tokenize({scs |> Reader.generate_scs(), gtl, ""}) == new_list
    end

    test "014_S1_Valid_ReturnPrecZero", context do
      gtl = Reader.generate_gtl(Hps.Lt.get_gtl_content())
      scs = """
      int main() {
        return 007;
      }
      """
      new_token = %Structs.Token{expression: "007", pos_x: nil, pos_y: nil, tag: "literal"}
      assert Lexer.tokenize({scs |> Reader.generate_scs(), gtl, ""}) == Hps.Lt.update_otl(context[:otl], new_token)
    end

end