defmodule StageOneParser do
  use ExUnit.Case

  setup_all do
    {:ok,
      [output_token_list:
        [
          %Structs.Token{expression: "int", pos_x: nil, pos_y: nil, tag: "int"},
          %Structs.Token{expression: "main", pos_x: nil, pos_y: nil, tag: "main"},
          %Structs.Token{expression: "(", pos_x: nil, pos_y: nil,
            tag: "parenthesis-open"
          },
          %Structs.Token{expression: ")", pos_x: nil, pos_y: nil,
            tag: "parenthesis-close"
          },
          %Structs.Token{expression: "{", pos_x: nil, pos_y: nil, 
            tag: "bracket-open"},
          %Structs.Token{expression: "return", pos_x: nil, pos_y: nil, 
            tag: "return"},
          %Structs.Token{expression: ";", pos_x: nil, pos_y: nil, 
            tag: "semicolon"},
          %Structs.Token{expression: "}", pos_x: nil, pos_y: nil, 
            tag: "bracket-close"}
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
    literal_token = %Structs.Node{
      asm: "movq $:t, %:r", 
      children: [], 
      class: "low-evaluation", 
      tag: "literal", 
      token: %Structs.Token{expression: "0", pos_x: nil, pos_y: nil, tag: "literal"}
    }
    mid_evaluation_token = %Structs.Node{
      asm: "movq %:0, %:r", 
      children: [literal_token], 
      class: "mid-evaluation", 
      tag: "mid-evaluation", 
      token: nil
    }
    high_evaluation_token = %Structs.Node{
      asm: "movq %:0, %:r", 
      children: [mid_evaluation_token], 
      class: "high-evaluation", 
      tag: "high-evaluation", 
      token: nil
    }

    # Parser inputs (otl, gast)
    new_literal_token = %Structs.Token{expression: "0", pos_x: nil, pos_y: nil, 
      tag: "literal"}
    output_token_list = Helpers.GeneralTester.insert_token_list(
      context[:output_token_list], [new_literal_token], 6
    )
    general_abstract_syntax_tree =  Helpers.GeneralTester.get_c_structures_content()
                                    |> Reader._generate_general_ast()
    {status_token, oast, token_list, error_cause} = 
      Parser.parse(output_token_list, general_abstract_syntax_tree)

    root = List.first(context[:oast])
    program_root = List.first(root.children)
    [int_node|[main_node|[opener|[closer|[open_function|[operation|
      [close_function|_tail]]]]]]] = program_root.children
    
    new_operation_children = Helpers.GeneralTester.insert_token_list(
      operation.children, [high_evaluation_token], 1
    )
    new_operation = %Structs.Node{
      asm: "movq %:1, %:r", 
      children: new_operation_children, 
      class: ["operation", "returner"], tag: "operation", 
      token: nil
    }

    new_program_root = %Structs.Node{
      asm: "movq %:5, %:r",
      children: [
        int_node, main_node, opener, closer, open_function, new_operation, 
        close_function
      ], 
      class: "program-root", 
      tag: "function", 
      token: nil
    }
    new_root = %Structs.Node{
      asm: "movq %:0, %rax", 
      children: [new_program_root], 
      class: :root, 
      tag: :root, 
      token: nil
    }

    # Parser outputs
    assert {status_token, oast, token_list, error_cause} == {:ok, new_root, [], nil}
  end

end