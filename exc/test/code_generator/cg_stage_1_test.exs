defmodule CodeGeneratorTest do
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
    
    # Regression tests
    test "001_S1_Valid_Return7" do
        general_token_list = Helpers.LexerTester.get_c_tokens_content()
        |> Reader._generate_general_token_list()
        source_code_string = """
        int main() {
          return 7;
        }
        """
        |> Reader._generate_source_code_string()
        
    end
    # test "001_S1_Valid_Return0" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_1/001_S1_Valid_Return0.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
    #     |> Filter.filter_parser_output(file_path, verbose)
    #     |> CodeGenerator.generate_code(verbose)s
        
    #     assert cg == "    .section        __TEXT,__text,regular,pure_instructions\n    .p2align        4, 0x90\n    .globl _main\n  _main: \n            \nmovl $0, %ebx\nmovl %ebx, %ecx\nmovl %ecx, %ebx\nmovl %ebx, %eax\n \n    ret\n"
    # end

    # test "002_S1_Valid_Return7" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_1/002_S1_Valid_Return7.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
    #     |> Filter.filter_parser_output(file_path, verbose)
    #     |> CodeGenerator.generate_code(verbose)
        
    #     assert cg == "    .section        __TEXT,__text,regular,pure_instructions\n    .p2align        4, 0x90\n    .globl _main\n  _main: \n            \nmovl $7, %ebx\nmovl %ebx, %ecx\nmovl %ecx, %ebx\nmovl %ebx, %eax\n \n    ret\n"
    # end

    # test "003_S1_Valid_ReturnMD130" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_1/003_S1_Valid_ReturnMD130.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
    #     |> Filter.filter_parser_output(file_path, verbose)
    #     |> CodeGenerator.generate_code(verbose)
        
    #     assert cg == "    .section        __TEXT,__text,regular,pure_instructions\n    .p2align        4, 0x90\n    .globl _main\n  _main: \n            \nmovl $130, %ebx\nmovl %ebx, %ecx\nmovl %ecx, %ebx\nmovl %ebx, %eax\n \n    ret\n"
    # end

    # test "004_S1_Valid_ReturnBlankSpaces" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_1/004_S1_Valid_ReturnBlankSpaces.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
    #     |> Filter.filter_parser_output(file_path, verbose)
    #     |> CodeGenerator.generate_code(verbose)
        
    #     assert cg == "    .section        __TEXT,__text,regular,pure_instructions\n    .p2align        4, 0x90\n    .globl _main\n  _main: \n            \nmovl $1, %ebx\nmovl %ebx, %ecx\nmovl %ecx, %ebx\nmovl %ebx, %eax\n \n    ret\n"
    # end

    # test "005_S1_Valid_ReturnNoLineB" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_1/005_S1_Valid_ReturnNoLineB.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
    #     |> Filter.filter_parser_output(file_path, verbose)
    #     |> CodeGenerator.generate_code(verbose)
        
    #     assert cg ==  "    .section        __TEXT,__text,regular,pure_instructions\n    .p2align        4, 0x90\n    .globl _main\n  _main: \n            \nmovl $1, %ebx\nmovl %ebx, %ecx\nmovl %ecx, %ebx\nmovl %ebx, %eax\n \n    ret\n"
    # end

    # test "006_S1_Valid_ReturnSpaceChars" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_1/006_S1_Valid_ReturnSpaceChars.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
    #     |> Filter.filter_parser_output(file_path, verbose)
    #     |> CodeGenerator.generate_code(verbose)
        
    #     assert cg == "    .section        __TEXT,__text,regular,pure_instructions\n    .p2align        4, 0x90\n    .globl _main\n  _main: \n            \nmovl $1, %ebx\nmovl %ebx, %ecx\nmovl %ecx, %ebx\nmovl %ebx, %eax\n \n    ret\n"
    # end

    # # This test must return a Lexer error. Thus, we just tokenize the input to assert the adequate behavior.
    # test "007_S1_Invalid_ReturnNull" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     file_path = "./examples/stage_1/007_S1_Invalid_ReturnNull.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
        
    #     assert cg == {%Structs.Token{expression: "return;", pos_x: nil, pos_y: nil, tag: "error"}, :error}
    # end

    # test "008_S1_Invalid_ReturnNoFuncName" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     file_path = "./examples/stage_1/008_S1_Invalid_ReturnNoFuncName.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
        
    #     assert cg == {
    #           [%Structs.Token{expression: "int", pos_x: nil, pos_y: nil, tag: "int"}, %Structs.Token{expression: "(", pos_x: nil, pos_y: nil, tag: "parenthesis-open"}, %Structs.Token{expression: ")", pos_x: nil, pos_y: nil, tag: "parenthesis-close"}, %Structs.Token{expression: "{", pos_x: nil, pos_y: nil, tag: "bracket-open"}, %Structs.Token{expression: "return", pos_x: nil, pos_y: nil, tag: "return"}, %Structs.Token{expression: "1", pos_x: nil, pos_y: nil, tag: "literal"}, %Structs.Token{expression: ";", pos_x: nil, pos_y: nil, tag: "semicolon"}, %Structs.Token{expression: "}", pos_x: nil, pos_y: nil, tag: "bracket-close"}],
    #           :ok
    #         }
    # end

    # test "009_S1_Invalid_ReturnNoParenth" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     file_path = "./examples/stage_1/009_S1_Invalid_ReturnNoParenth.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
        
    #     assert cg == {
    #           [
    #             %Structs.Token{
    #               expression: "int",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "int"
    #             },
    #             %Structs.Token{
    #               expression: "main",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "main"
    #             },
    #             %Structs.Token{
    #               expression: ")",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "parenthesis-close"
    #             },
    #             %Structs.Token{
    #               expression: "{",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "bracket-open"
    #             },
    #             %Structs.Token{
    #               expression: "return",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "return"
    #             },
    #             %Structs.Token{
    #               expression: "1",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "literal"
    #             },
    #             %Structs.Token{
    #               expression: ";",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "semicolon"
    #             },
    #             %Structs.Token{
    #               expression: "}",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "bracket-close"
    #             }
    #           ],
    #           :ok
    #         }
    # end

    # test "010_S1_Invalid_ReturnNoBrack" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     file_path = "./examples/stage_1/010_S1_Invalid_ReturnNoBrack.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
        
    #     assert cg == {
    #           [
    #             %Structs.Token{
    #               expression: "int",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "int"
    #             },
    #             %Structs.Token{expression: "main", pos_x: nil, pos_y: nil, tag: "main"},
    #             %Structs.Token{
    #               expression: "(",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "parenthesis-open"
    #             },
    #             %Structs.Token{
    #               expression: ")",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "parenthesis-close"
    #             },
    #             %Structs.Token{
    #               expression: "return",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "return"
    #             },
    #             %Structs.Token{
    #               expression: "13",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "literal"
    #             },
    #             %Structs.Token{
    #               expression: ";",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "semicolon"
    #             },
    #             %Structs.Token{
    #               expression: "}",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "bracket-close"
    #             }
    #           ],
    #           :ok
    #         }
    # end

    # test "011_S1_Invalid_ReturnNoSpaces" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     file_path = "./examples/stage_1/011_S1_Invalid_ReturnNoSpaces.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
        
    #     assert cg == {
    #           %Structs.Token{expression: "intmain()", pos_x: nil, pos_y: nil, tag: "error"},
    #           :error
    #         }
    # end

    # test "012_S1_Invalid_ReturnComma" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     file_path = "./examples/stage_1/012_S1_Invalid_ReturnComma.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
        
    #     assert cg == {%Structs.Token{expression: ",", pos_x: nil, pos_y: nil, tag: "error"}, :error}
    # end

    # test "013_S1_Invalid_ReturnCaps" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     file_path = "./examples/stage_1/013_S1_Invalid_ReturnCaps.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
        
    #     assert cg == {
    #           %Structs.Token{expression: "Int", pos_x: nil, pos_y: nil, tag: "error"},
    #           :error
    #         }
    # end

    # test "014_S1_Valid_ReturnPrecZero" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_1/014_S1_Valid_ReturnPrecZero.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
    #     |> Filter.filter_parser_output(file_path, verbose)
    #     |> CodeGenerator.generate_code(verbose)
        
    #     assert cg == "    .section        __TEXT,__text,regular,pure_instructions\n    .p2align        4, 0x90\n    .globl _main\n  _main: \n            \nmovl $007, %ebx\nmovl %ebx, %ecx\nmovl %ecx, %ebx\nmovl %ebx, %eax\n \n    ret\n"
    # end

    # # Stage 2 tests
    # test "015_S2_Valid_Negative" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_2/015_S2_Valid_Negative.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
    #     |> Filter.filter_parser_output(file_path, verbose)
    #     |> CodeGenerator.generate_code(verbose)
        
    #     assert cg == "    .section        __TEXT,__text,regular,pure_instructions\n    .p2align        4, 0x90\n    .globl _main\n  _main: \n            \nmovl $7, %ebx\nneg %ebx\nmovl %ebx, %ecx\nmovl %ecx, %ebx\nmovl %ebx, %ecx\nmovl %ecx, %eax\n \n    ret\n"
    # end

    # test "016_S2_Valid_Bitwise" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_2/016_S2_Valid_Bitwise.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
    #     |> Filter.filter_parser_output(file_path, verbose)
    #     |> CodeGenerator.generate_code(verbose)
        
    #     assert cg == "    .section        __TEXT,__text,regular,pure_instructions\n    .p2align        4, 0x90\n    .globl _main\n  _main: \n            \nmovl $7, %ebx\nnot %ebx\nmovl %ebx, %ecx\nmovl %ecx, %ebx\nmovl %ebx, %ecx\nmovl %ecx, %eax\n \n    ret\n"
    # end

    # test "017_S2_Valid_Bitwise0" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_2/017_S2_Valid_Bitwise_0.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
    #     |> Filter.filter_parser_output(file_path, verbose)
    #     |> CodeGenerator.generate_code(verbose)
        
    #     assert cg == "    .section        __TEXT,__text,regular,pure_instructions\n    .p2align        4, 0x90\n    .globl _main\n  _main: \n            \nmovl $0, %ebx\nnot %ebx\nmovl %ebx, %ecx\nmovl %ecx, %ebx\nmovl %ebx, %ecx\nmovl %ecx, %eax\n \n    ret\n"
    # end

    # test "018_S2_Valid_Not_7" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_2/018_S2_Valid_Not_7.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
    #     |> Filter.filter_parser_output(file_path, verbose)
    #     |> CodeGenerator.generate_code(verbose)
        
    #     assert cg == "    .section        __TEXT,__text,regular,pure_instructions\n    .p2align        4, 0x90\n    .globl _main\n  _main: \n            \nmovl $7, %ebx\nnotl %ebx\nmovl %ebx, %ecx\nmovl %ecx, %ebx\nmovl %ebx, %ecx\nmovl %ecx, %eax\n \n    ret\n"
    # end

    # test "019_S2_Valid_Not_0" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_2/019_S2_Valid_Not_0.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
    #     |> Filter.filter_parser_output(file_path, verbose)
    #     |> CodeGenerator.generate_code(verbose)
        
    #     assert cg == "    .section        __TEXT,__text,regular,pure_instructions\n    .p2align        4, 0x90\n    .globl _main\n  _main: \n            \nmovl $0, %ebx\nnotl %ebx\nmovl %ebx, %ecx\nmovl %ecx, %ebx\nmovl %ebx, %ecx\nmovl %ecx, %eax\n \n    ret\n"
    # end

    # test "020_S2_Valid_Multiple_Ops_1" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_2/020_S2_Valid_Multiple_Ops_1.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
    #     |> Filter.filter_parser_output(file_path, verbose)
    #     |> CodeGenerator.generate_code(verbose)
        
    #     assert cg == "    .section        __TEXT,__text,regular,pure_instructions\n    .p2align        4, 0x90\n    .globl _main\n  _main: \n            \nmovl $7, %ebx\nnot %ebx\nmovl %ebx, %ecx\nneg %ecx\nmovl %ecx, %ebx\nmovl %ebx, %ecx\nmovl %ecx, %ebx\nmovl %ebx, %eax\n \n    ret\n"
    # end

    # test "021_S2_Valid_Multiple_Ops_2" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_2/021_S2_Valid_Multiple_Ops_2.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
    #     |> Filter.filter_parser_output(file_path, verbose)
    #     |> CodeGenerator.generate_code(verbose)
        
    #     assert cg == "    .section        __TEXT,__text,regular,pure_instructions\n    .p2align        4, 0x90\n    .globl _main\n  _main: \n            \nmovl $4, %ebx\nneg %ebx\nmovl %ebx, %ecx\nnotl %ecx\nmovl %ecx, %ebx\nmovl %ebx, %ecx\nmovl %ecx, %ebx\nmovl %ebx, %eax\n \n    ret\n"
    # end

    # test "022_S2_Valid_Multiple_Ops_3" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_2/022_S2_Valid_Multiple_Ops_3.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
    #     |> Filter.filter_parser_output(file_path, verbose)
    #     |> CodeGenerator.generate_code(verbose)
        
    #     assert cg == "    .section        __TEXT,__text,regular,pure_instructions\n    .p2align        4, 0x90\n    .globl _main\n  _main: \n            \nmovl $0, %ebx\nnot %ebx\nmovl %ebx, %ecx\nnotl %ecx\nmovl %ecx, %ebx\nmovl %ebx, %ecx\nmovl %ecx, %ebx\nmovl %ebx, %eax\n \n    ret\n"
    # end

    # test "023_S2_Invalid_Wrong_Order_Negative" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_2/023_S2_Invalid_Wrong_Order_Negative.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
        
    #     assert cg == {:token_missing_error, %Structs.Node{asm: "movl %:0, %eax", children: [%{"class" => "program-root", "tag" => "program-root"}], class: :root, tag: :root, token: nil}, [%Structs.Token{expression: "int", pos_x: nil, pos_y: nil, tag: "int"}, %Structs.Token{expression: "main", pos_x: nil, pos_y: nil, tag: "main"}, %Structs.Token{expression: "(", pos_x: nil, pos_y: nil, tag: "parenthesis-open"}, %Structs.Token{expression: ")", pos_x: nil, pos_y: nil, tag: "parenthesis-close"}, %Structs.Token{expression: "{", pos_x: nil, pos_y: nil, tag: "bracket-open"}, %Structs.Token{expression: "return", pos_x: nil, pos_y: nil, tag: "return"}, %Structs.Token{expression: "7", pos_x: nil, pos_y: nil, tag: "literal"}, %Structs.Token{expression: "-", pos_x: nil, pos_y: nil, tag: "minus"}, %Structs.Token{expression: ";", pos_x: nil, pos_y: nil, tag: "semicolon"}, %Structs.Token{expression: "}", pos_x: nil, pos_y: nil, tag: "bracket-close"}], %Structs.Node{asm: "movl %:1, %:r", children: [%{"class" => "return-word", "tag" => "return"}, %{"class" => "evaluation", "tag" => "evaluation"}, %{"class" => "line-ender", "tag" => "semicolon"}], class: ["operation", "returner"], tag: "operation", token: nil}}
    # end

    # test "024_S2_Invalid_Correct_Neg_Wrong_Bitwise_Order" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_2/024_S2_Invalid_Correct_Neg_Wrong_Bitwise_Order.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
        
    #     assert cg == {
    #           :token_missing_error,
    #           %Structs.Node{
    #             asm: "movl %:0, %eax",
    #             children: [
    #               %{"class" => "program-root", "tag" => "program-root"}
    #             ],
    #             class: :root,
    #             tag: :root,
    #             token: nil
    #           },
    #           [
    #             %Structs.Token{
    #               expression: "int",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "int"
    #             },
    #             %Structs.Token{
    #               expression: "main",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "main"
    #             },
    #             %Structs.Token{
    #               expression: "(",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "parenthesis-open"
    #             },
    #             %Structs.Token{
    #               expression: ")",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "parenthesis-close"
    #             },
    #             %Structs.Token{
    #               expression: "{",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "bracket-open"
    #             },
    #             %Structs.Token{
    #               expression: "return",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "return"
    #             },
    #             %Structs.Token{
    #               expression: "-",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "minus"
    #             },
    #             %Structs.Token{expression: "5", pos_x: nil, pos_y: nil, tag: "literal"},
    #             %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, tag: "complement"},
    #             %Structs.Token{
    #               expression: ";",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "semicolon"
    #             },
    #             %Structs.Token{
    #               expression: "}",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "bracket-close"
    #             }
    #           ],
    #           %Structs.Node{
    #             asm: "movl %:1, %:r",
    #             children: [
    #               %{"class" => "return-word", "tag" => "return"},
    #               %{"class" => "evaluation", "tag" => "evaluation"},
    #               %{"class" => "line-ender", "tag" => "semicolon"}
    #             ],
    #             class: ["operation", "returner"],
    #             tag: "operation",
    #             token: nil
    #           }
    #         }
    # end

    # test "025_S2_Invalid_Bitwise_No_Semicolon" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_2/025_S2_Invalid_Bitwise_No_Semicolon.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
        
    #     assert cg == {
    #           :token_missing_error,
    #           %Structs.Node{
    #             asm: "movl %:0, %eax",
    #             children: [
    #               %{"class" => "program-root", "tag" => "program-root"}
    #             ],
    #             class: :root,
    #             tag: :root,
    #             token: nil
    #           },
    #           [
    #             %Structs.Token{
    #               expression: "int",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "int"
    #             },
    #             %Structs.Token{
    #               expression: "main",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "main"
    #             },
    #             %Structs.Token{
    #               expression: "(",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "parenthesis-open"
    #             },
    #             %Structs.Token{
    #               expression: ")",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "parenthesis-close"
    #             },
    #             %Structs.Token{
    #               expression: "{",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "bracket-open"
    #             },
    #             %Structs.Token{
    #               expression: "return",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "return"
    #             },
    #             %Structs.Token{
    #               expression: "0",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "literal"
    #             },
    #             %Structs.Token{
    #               expression: "}",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "bracket-close"
    #             }
    #           ],
    #           %Structs.Node{
    #             asm: "movl %:1, %:r",
    #             children: [
    #               %{"class" => "return-word", "tag" => "return"},
    #               %{"class" => "evaluation", "tag" => "evaluation"},
    #               %{"class" => "line-ender", "tag" => "semicolon"}
    #             ],
    #             class: ["operation", "returner"],
    #             tag: "operation",
    #             token: nil
    #           }
    #         }
    # end

    # test "026_S2_Invalid_Not_Missing_Const" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_2/026_S2_Invalid_Not_Missing_Const.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
        
    #     assert cg == {
    #           :token_missing_error,
    #           %Structs.Node{
    #             asm: "movl %:0, %eax",
    #             children: [
    #               %{"class" => "program-root", "tag" => "program-root"}
    #             ],
    #             class: :root,
    #             tag: :root,
    #             token: nil
    #           },
    #           [
    #             %Structs.Token{
    #               expression: "int",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "int"
    #             },
    #             %Structs.Token{
    #               expression: "main",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "main"
    #             },
    #             %Structs.Token{
    #               expression: "(",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "parenthesis-open"
    #             },
    #             %Structs.Token{
    #               expression: ")",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "parenthesis-close"
    #             },
    #             %Structs.Token{
    #               expression: "{",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "bracket-open"
    #             },
    #             %Structs.Token{
    #               expression: "return",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "return"
    #             },
    #             %Structs.Token{
    #               expression: "!",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "negation"
    #             },
    #             %Structs.Token{expression: ";", pos_x: nil, pos_y: nil, tag: "semicolon"},
    #             %Structs.Token{
    #               expression: "}",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "bracket-close"
    #             }
    #           ],
    #           %Structs.Node{
    #             asm: "movl %:1, %:r",
    #             children: [
    #               %{"class" => "return-word", "tag" => "return"},
    #               %{"class" => "evaluation", "tag" => "evaluation"},
    #               %{"class" => "line-ender", "tag" => "semicolon"}
    #             ],
    #             class: ["operation", "returner"],
    #             tag: "operation",
    #             token: nil
    #           }
    #         }
    # end

    # test "027_S2_Invalid_Not_Bitwise_Const" do
    #     verbose = false
    #     c_tokens_path = "./specification_files/c_tokens.xml"
    #     c_structures_path = "./specification_files/c_structures.xml"
    #     file_path = "./examples/stage_2/027_S2_Invalid_Not_Bitwise_Const.c"
        
    #     cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
    #     |> Lexer.tokenize()
    #     |> Filter.filter_lexer_output(file_path, verbose)
    #     |> Parser.parse(Reader.read_general_ast(c_structures_path))
        
    #     assert cg == {
    #           :token_missing_error,
    #           %Structs.Node{
    #             asm: "movl %:0, %eax",
    #             children: [
    #               %{"class" => "program-root", "tag" => "program-root"}
    #             ],
    #             class: :root,
    #             tag: :root,
    #             token: nil
    #           },
    #           [
    #             %Structs.Token{
    #               expression: "int",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "int"
    #             },
    #             %Structs.Token{
    #               expression: "main",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "main"
    #             },
    #             %Structs.Token{
    #               expression: "(",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "parenthesis-open"
    #             },
    #             %Structs.Token{
    #               expression: ")",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "parenthesis-close"
    #             },
    #             %Structs.Token{
    #               expression: "{",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "bracket-open"
    #             },
    #             %Structs.Token{
    #               expression: "return",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "return"
    #             },
    #             %Structs.Token{
    #               expression: "!",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "negation"
    #             },
    #             %Structs.Token{expression: "~", pos_x: nil, pos_y: nil, tag: "complement"},
    #             %Structs.Token{expression: ";", pos_x: nil, pos_y: nil, tag: "semicolon"},
    #             %Structs.Token{
    #               expression: "}",
    #               pos_x: nil,
    #               pos_y: nil,
    #               tag: "bracket-close"
    #             }
    #           ],
    #           %Structs.Node{
    #             asm: "movl %:1, %:r",
    #             children: [
    #               %{"class" => "return-word", "tag" => "return"},
    #               %{"class" => "evaluation", "tag" => "evaluation"},
    #               %{"class" => "line-ender", "tag" => "semicolon"}
    #             ],
    #             class: ["operation", "returner"],
    #             tag: "operation",
    #             token: nil
    #           }
    #         }
    # end
end