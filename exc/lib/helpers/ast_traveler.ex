defmodule Helpers.ASTTraveler do
  @moduledoc """
  Travels through an Abstract Syntax Tree.
  """ 
  @num_spaces "   " #3 spaces
  
  @doc """
  Returns a string that results from the traveling of the Abstract Syntax Tree.
  ## Specs  
  ```root```  : abstract syntax tree. An example of an AST is the output 
      from `Parser.parse/2`.

  ```num```   : number of iteration; when calling this function, its value 
      should always be 0. 
  """
  def travel(root, num)                                     do
    if num == 0, do: "{#{root.tag} => {#{decide(root)}}}"
    Enum.map(root.children, 
      fn x -> 
        if x.children == [],
          do: "\n" 
            <> String.duplicate(@num_spaces, num + 1) 
            <> "{#{x.tag} => #{x.token.expression}}",
          else: "\n" 
            <> String.duplicate(@num_spaces, num + 1) 
            <> "{#{x.tag} => #{decide(x)}}" 
            <> "#{travel(x, num + 1)}"
      end
    )
  end
  
  defp decide(node)                                         do 
    if node.token == nil, 
      do:   "", 
      else: node.token.expression
  end
end