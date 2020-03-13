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
  def start(file_path) do 
    Reader.load(file_path)
    |> Lexer.tokenize()
    |> IO.inspect(label: "OTL")
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
