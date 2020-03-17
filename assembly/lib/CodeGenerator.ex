defmodule CodeGenerator.Node do

  def print_principal_segments do
    """
    .section .data
    .section .text
    .global _main
    _main:
    
    """
  end

  def search_token(%Structs.Node{}, %Structs.Token{}) do
    s1 = %Structs.Node{}
    s2 = %Structs.Token{}
    if s1.tag == "literal" do

      lit = s2.expression
      print_principal_segments()
      <>
      """
      mov $#{lit},%rax
      ret

      """

    end
  end
end