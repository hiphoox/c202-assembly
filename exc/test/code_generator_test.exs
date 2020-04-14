defmodule CodeGeneratorTest do
    use ExUnit.Case
    doctest CodeGenerator

    test "001_S1_Valid_Return0" do
        verbose = false
        file_path = "./examples/test.c"
        c_tokens_path = "./specification_files/c_tokens.xml"
        c_structures_path = "./specification_files/c_structures.xml"
        
        cg = Reader.read_code_and_tokens(file_path, c_tokens_path, verbose)
        |> Lexer.tokenize()
        |> Filter.filter_lexer_output(file_path, verbose)
        |> Parser.parse(Reader.read_general_ast(c_structures_path))
        |> Filter.filter_parser_output(file_path, verbose)
        |> CodeGenerator.generate_code(verbose)
        
        assert cg == "    .section        __TEXT,__text,regular,pure_instructions\n    .p2align        4, 0x90\n    .globl _main\n  _main: \n            \nmovl $0, %ebx\nmovl %ebx, %ecx\nmovl %ecx, %ebx\nmovl %ebx, %eax\n \n    ret\n"
    end

end