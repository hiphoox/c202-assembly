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
    + **-v** or **--verbose**  : executes the compiler with logs on each step
  
  ## Examples
  ```
    $ ./exc <file_to_compile>
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

  defp filter_args({_,[file_path],_})                                   do
    start_compilation(file_path, "", false)
  end

  
  @doc """
  Starts the compilation process given an input path.
  ### Specs  
  ```file_path``` is the path to the file to be compiled.
  ```verbose``` boolean to indicate if there should be a detailed output of each 
    of the compiler's stages.
  
  ### Examples
  ```
    $ ./exc examples/test.c
  ``` 
  """
  def start_compilation(file_path, output_file_name \\ "", verbose)     do
    Reader.read_code_and_tokens(file_path, @c_tokens_path, verbose)
    |> Lexer.tokenize()
    |> Filter.filter_lexer_output(file_path, verbose)
    |> Parser.parse(Reader.read_general_ast(@c_structures_path))
    |> Filter.filter_parser_output(file_path, verbose)
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
    case module do
      "r"
        -> Common.ModuleCompilator.start_reader(file_path, all_trace)
      "l"
        -> Common.ModuleCompilator.start_lexer(file_path, all_trace)
      "p"
        -> Common.ModuleCompilator.start_parser(file_path, all_trace)
      "c"
        -> Common.ModuleCompilator.start_code_generator(file_path, all_trace)
    end
  end
end
