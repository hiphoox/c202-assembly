defmodule StageOneParser do
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
      ]
    }
    end

  test "001_S1_Valid_Return0", context do
    # Test token
    literal_token = %Structs.Token{expression: "0", pos_x: nil, pos_y: nil, tag: "literal"}

    # Parser inputs (otl, gast)
    output_token_list = Helpers.LexerTester.insert_token_list(
      context[:output_token_list], [literal_token], 6
    )
    general_abstract_syntax_tree =  Helpers.LexerTester.get_c_structures_content()
                                    |> Reader._generate_general_ast()
    {status_token, output_abstract_syntax_tree, token_list, error_cause} = 
      Parser.parse(output_token_list, general_abstract_syntax_tree)

    oast_root = output_abstract_syntax_tree
    class = oast_root.class

    # Parser outputs
    assert [class] == [:root]
    
  end

end