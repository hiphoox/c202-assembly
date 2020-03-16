defmodule Assembly do
  @moduledoc """
  This module is the main entry point and 
  handles all the command line parsing. 
  """

  @doc """
  'argv' can take any of the following values:
     -h or --help     : displays help regarding the use of the compiler
     -v or --verbose  : executes the compiler with logs on each step
     file_path        : path to the input source file
  main(argv) will be in charge of filtering the args and 
  passing it to the right function for extra processing.
  """
  def main(argv) do
    argv
    |> _parse_args
    |> _filter_args
  end

  @doc """
  'file_path' is the path to the input source file 
  the compiler will be compiling.
  """
  def start(file_path \\ "examples/test.c") do 
    otl = Reader.load(file_path) |> Lexer.tokenize()
    gast = Reader.load_gast()
    {result_token,oast,tl,error_cause} = Parser.parse(otl, gast)
    if result_token === :ok do
      Hps.OASTPrinter.print(oast)#Podemos continuar
      :ok
    else
      if result_token === :token_missing_error do
        IO.puts("[Parser Error]: Structure <#{error_cause.tag}> is missing something.")
        :error
      else
        IO.puts("[Parser Error]: Token <#{Enum.at(tl,0).expression}> was not accepted.")
        :error
      end
    end
  end

  def test(file_path \\ "examples/test.c") do
    otl = (Reader.load(file_path) |> Lexer.tokenize())
    gast = Reader.load_gast()
    Parser.parse(otl,gast)
  end

  defp _parse_args(argv) do 
    OptionParser.parse(argv, switches: [help: :boolean, verbose: :boolean], 
                                       aliases: [h: :help, v: :verbose])
  end

  defp _filter_args({[help: true],_,_}) do
    IO.puts "help"
  end

  defp _filter_args({[verbose: true],file_path,_}) do
    IO.puts "verbose #{file_path}"
  end

  defp _filter_args({_,file_path,_}) do
    start(file_path)
  end

end
