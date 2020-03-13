defmodule LexerTest do
    use ExUnit.Case
    doctest Lexer

    setup_all do
        {:ok,
         tokens: 
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
                  expression: ") ",
                  pos_x: nil,
                  pos_y: nil,
                  tag: "parenthesis-close"
                },
                %Structs.Token{expression: "{", pos_x: nil, pos_y: nil, tag: "bracket-open"},
                %Structs.Token{expression: "return ", pos_x: nil, pos_y: nil, tag: "return"},
                %Structs.Token{expression: "2", pos_x: nil, pos_y: nil, tag: "literal"},
                %Structs.Token{expression: ";", pos_x: nil, pos_y: nil, tag: "semicolon"},
                %Structs.Token{expression: "}", pos_x: nil, pos_y: nil, tag: "bracket-close"}
            ]
         }
      end

    test "return 2", state do
        code = """
          int main() {
            return 2;
        }
        """
        
        assert Lexer.tokenize(code) == state[:tokens]
    end
    
end