defmodule Reader do
  @moduledoc """
  Reads all the files the compiler needs.
  """

  @doc """
  Reads the source code from a file path and a general token list from an XML file.
  ## Specs
  ```raw_source_code_string``` is source code without any format coming from ```File.read!(path)```
  ```tokens_path``` is the path to an XML file containing the target language's valid token list.
  ```verbose``` a boolean value indicating if the compiler should output all of its steps.

  Generates the following output:
  + Source Code String (SCS): source code contained in a string.
  + General Token List (GTL): list of target language valid tokens.

  ## Examples
      iex> {scs, gtl} = Reader.read_code_and_tokens('examples/test.c',
      "specification_files/c_tokens.xml")
  """
  def read_code_and_tokens(raw_source_code_string, tokens_path, verbose \\ false) do
    scs = clean_source_code_string(raw_source_code_string)
    gtl = read_general_token_list(tokens_path)
    if verbose do
      IO.Printer.print_element(Common.StringElements.scs, scs)
      inspect = true
      IO.Printer.print_element(Common.StringElements.gtl, gtl, inspect)
    end
    {scs, gtl}
  end

  @doc """
  Cleans the source code as a string.
  ## Specs
  ```file_content``` is the path to the file to be compiled.

  Generates the following output:
  + Source Code String (SCS): String.

  ## Examples
  ```
      iex> scs = Reader.clean_source_code_string(File.read!("examples/test_s2.c"))
      "int main(){
       return -7;
       }"
  ```
  """
  def clean_source_code_string(file_content)             do
    String.trim(file_content)
    |> String.replace("\n", " ")
    |> String.replace("\t", " ")
  end

  @doc """
  Reads the structure of the target language's valid tokens as a General Token List (GTL).
  ## Specs
  ```tokens_path``` is the path to an XML file containing the target language's valid token list.

  Generates the following output:
  + General Token List (GTL): list of target language's valid tokens.

  ## Examples
      iex> gtl = Reader.read_general_token_list("specification_files/c_tokens.xml")
  """
  def read_general_token_list(tokens_path)                do
    File.read!(tokens_path)
    |> _generate_general_token_list()
  end

  def _generate_general_token_list(file_content)          do
    XmlToMap.naive_map(file_content)
    |> generate_useful_list()
    |> parse_to_token_list()
    |> add_error_token()
  end

  defp parse_to_token_list(list)                          do
    Enum.map list, fn(token) ->
      %Structs.Token{
        tag:        token["tag"],
        expression: token["expression"],
        pos_y:      nil,
        pos_x:      nil,
      }
    end
  end

  defp add_error_token(gtl)                               do
    gtl ++ [
      %Structs.Token{
        tag: "error",
        expression: "\\S+",
        pos_y: nil,
        pos_x: nil
      }
    ]
  end

  @doc """
  Reads the structure of the target language's grammar production rules from an XML file.
  ## Specs
  ```grammar_prod_rules_path``` is the path to an XML file containing the target language's grammar production rules.

  Generates the following output:
  + General Abstract Syntax Treee (GAST): list containing the target language
    grammar production rules.

  ## Examples
      # iex> gast = Reader.read_general_ast(grammar_prod_rules_path)
  """
  def read_general_ast(grammar_prod_rules_path)           do
    File.read!(grammar_prod_rules_path)
    |> _generate_general_ast()
  end

  def _generate_general_ast(file_content)                 do
    XmlToMap.naive_map(file_content)
    |> generate_useful_list()
    |> parse_to_node_list()
  end

  defp generate_useful_list(map)                          do
    [general_list | _] = Map.values map
    [useful_list | _ ] = Map.values general_list
    useful_list
  end

  defp parse_to_node_list(list)                           do
    Enum.map list, fn(node) ->
      %Structs.Node{
        tag:      node["tag"],
        token:    get_t(node),
        children: [get_c(node)] |> List.flatten,
        class:    node["class"],
        asm:      get_asm(node)
      }
    end
  end

  defp get_c(node)                                        do
    if node["substructure"] == nil, do: [], else: node["substructure"]
  end

  defp get_t(node)                                        do
    if node["token"] == %{}, do: nil, else: node["token"]
  end

  defp get_asm(node)                                      do
    if node["asm"] == %{}, do: "", else: node["asm"]
  end
end
