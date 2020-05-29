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
        ],
        oast:
        [
          %Structs.Node{asm: "movl %:0, %eax", 
          children: [
            %Structs.Node{asm: "movl %:5, %:r",
            children: [
              %Structs.Node{asm: "", children: [], class: "data-type", tag: "int-data-type", token: %Structs.Token{expression: "int", pos_x: nil, pos_y: nil, tag: "int"}},
              %Structs.Node{asm: "", children: [], class: "function-name", tag: "main-function-name", token: %Structs.Token{expression: "main", pos_x: nil, pos_y: nil, tag: "main"}},
              %Structs.Node{asm: "", children: [], class: ["group-opener", "args-opener"], tag: "evaluator-open", token: %Structs.Token{expression: "(", pos_x: nil, pos_y: nil, tag: "parenthesis-open"}},
              %Structs.Node{asm: "", children: [], class: ["group-closer", "args-closer"], tag: "evaluator-close", token: %Structs.Token{expression: ")", pos_x: nil, pos_y: nil, tag: "parenthesis-close"}},
              %Structs.Node{asm: "", children: [], class: "function-opener", tag: "section-open", token: %Structs.Token{expression: "{", pos_x: nil, pos_y: nil, tag: "bracket-open"}},
              %Structs.Node{asm: "movl %:1, %:r", 
              children: [
                %Structs.Node{asm: "", children: [], class: "return-word", tag: "return-word", token: %Structs.Token{expression: "return", pos_x: nil, pos_y: nil, tag: "return"}},
                # %Structs.Node{asm: "mov %:0, %:r",
                %Structs.Node{asm: "", children: [], class: "line-ender", tag: "semicolon", token: %Structs.Token{expression: ";", pos_x: nil, pos_y: nil, tag: "semicolon"}}
              ], class: ["operation", "returner"], tag: "operation", token: nil},

              %Structs.Node{asm: "", children: [], class: "function-closer", tag: "section-close", token: %Structs.Token{expression: "}", pos_x: nil, pos_y: nil, tag: "bracket-close"}}
            ], 
            class: "program-root", tag: "function", token: nil}
          ], 
          class: :root, tag: :root, token: nil}
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
    {status_token, oast, token_list, error_cause} = 
      Parser.parse(output_token_list, general_abstract_syntax_tree)

    # Parser outputs
    assert {status_token, oast, token_list, error_cause} == {:ok, List.first(context[:oast]), [], nil}
  end

end