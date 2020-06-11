defmodule Common.ModuleCompilator do
  @moduledoc false

  @c_tokens_path "./specification_files/c_tokens.xml"
  @c_structures_path "./specification_files/c_structures.xml"

  def start_reader(file_path, _)                                do
    IO.puts("==============")
    IO.puts("Reader")
    IO.puts("==============")
    raw_source_code_string = File.read!(file_path)
    Reader.read_code_and_tokens(raw_source_code_string, @c_tokens_path, true)
  end

  def start_lexer(file_path, _)                         do
    IO.puts("==============")
    IO.puts("Lexer")
    IO.puts("==============")
    raw_source_code_string = File.read!(file_path)
    Reader.read_code_and_tokens(raw_source_code_string, @c_tokens_path, all_trace)
    |> Lexer.tokenize()
    |> IO.inspect(label: "OTL")
  end

  def start_parser(file_path, all_trace)                        do
    IO.puts("==============")
    IO.puts("Parser")
    IO.puts("==============")
    raw_source_code_string = File.read!(file_path)
    Reader.read_code_and_tokens(raw_source_code_string, @c_tokens_path, all_trace)
    |> Lexer.tokenize()
    |> Filter.filter_lexer_output(file_path, raw_source_code_string, all_trace)
    |> Parser.parse(Reader.read_general_ast(@c_structures_path))
    |> IO.inspect(label: "OAST")
  end

  def start_code_generator(file_path, all_trace)                do
    IO.puts("==============")
    IO.puts("Code Generator")
    IO.puts("==============")
    raw_source_code_string = File.read!(file_path)
    Reader.read_code_and_tokens(raw_source_code_string, @c_tokens_path, all_trace)
    |> Lexer.tokenize()
    |> Filter.filter_lexer_output(file_path, raw_source_code_string, all_trace)
    |> Parser.parse(Reader.read_general_ast(@c_structures_path))
    |> Filter.filter_parser_output(file_path, raw_source_code_string, all_trace)
    |> CodeGenerator.generate_code(all_trace)
    |> IO.inspect(label: "Code generated")
  end
end
