defmodule ExC do
  @moduledoc """
  Main entry point that handles all the compiling process.
  """
  @c_tokens_path "./specification_files/c_tokens.xml"
  @c_structures_path "./specification_files/c_structures.xml"
  @doc """
  Filters command line arguments.
  ## Specs
  ```argv``` can take any of the following values:
    + **-h** or **--help**     : displays help regarding the use of the compiler
    + **-v** or **--verbose**  : executes the compiler with logs on each step
  ## Examples
  ```
    $ ./exc <file-path>
    $ ./exc -h (--help)
    $ ./exc <file-path> -o <my-output-file> -v
    $ ./exc <file-path> -v -o <my-output-file>
    $ ./exc <file-path> -v
    $ ./exc <file-path> -o <my-output-file>
  ```
  """
  def main(argv)                                                        do
    OptionParser.parse(argv, switches:
    [help: :boolean, verbose: :boolean, module: :boolean, output: :boolean],
    aliases: [h: :help, v: :verbose, m: :module, o: :output])
    |> filter_args
  end

  defp filter_args({[help: true],_,_})                                  do
    IO.puts "help"
  end

  defp filter_args({[output: true, verbose: true],[file_path, output_file_name],_}) do
    start_compilation(file_path, output_file_name, true)
  end

  defp filter_args({[verbose: true, output: true],[file_path, output_file_name],_}) do
    start_compilation(file_path, output_file_name, true)
  end


  defp filter_args({[verbose: true],[file_path],_})                     do
    start_compilation(file_path, "", true)
  end

  defp filter_args({[module: true], [file_path, module, all_trace], _}) do
    # all_trace is a flag to indicate if the ouput should contain
    # only the module output or the whole compilation process trace up until that
    # module
    case all_trace do
      "0"
        -> start_module_compilation(file_path, module, false)
      "1"
        -> start_module_compilation(file_path, module, true)
    end
  end


  defp filter_args({[output: true],[file_path, output_file_name],_})    do
    start_compilation(file_path, output_file_name, false)
  end

  #./exc <file-path>
  # in this case, the executable will be found at output.o
  # therefore, you should run ./output.o
  defp filter_args({_,[file_path],_})                                   do
    start_compilation(file_path, "", false)
  end

  defp start_compilation(file_path, output_file_name, verbose)     do
    # Note: if you add another module, remember to update GeneralTester's
    # start_general_test_compilation method
    raw_source_code_string = File.read!(file_path)
    Reader.read_code_and_tokens(raw_source_code_string, @c_tokens_path, verbose)
    |> Lexer.tokenize()
    |> Filter.filter_lexer_output(file_path, raw_source_code_string, verbose)
    |> Parser.parse(Reader.read_general_ast(@c_structures_path))
    |> Filter.filter_parser_output(file_path, raw_source_code_string, verbose)
    |> CodeGenerator.generate_code(verbose)
    |> CodeOptimizer.optimize(verbose)
    |> CodeConnector.connect(verbose)
    |> Writer.write_file()
    |> Invoker.invoke_gcc(output_file_name)
  end

  def _test(file_path \\ "examples/test.c")                             do
    otl = (Reader.read_code_and_tokens(file_path, @c_tokens_path)
          |> Lexer.tokenize())
    gast = Reader.read_general_ast(@c_structures_path)
    Parser.parse(otl,gast)
  end

  defp start_module_compilation(file_path, module, all_trace)           do
    # all_trace is either 0 or 1
    # 0 -> only module's output
    # 1 -> module's output and previous module's output
    case module do
      #reader
      "r"
        -> Common.ModuleCompilator.start_reader(file_path, all_trace)
      #lexer
      "l"
        -> Common.ModuleCompilator.start_lexer(file_path, all_trace)
      #parser
      "p"
        -> Common.ModuleCompilator.start_parser(file_path, all_trace)
      #code-generator
      "c"
        -> Common.ModuleCompilator.start_code_generator(file_path, all_trace)
    end
  end
end
