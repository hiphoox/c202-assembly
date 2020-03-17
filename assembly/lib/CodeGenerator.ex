defmodule CodeGenerator do

  def generate_code(oast) do
    return_node = get_node_with_tag(Enum.at(oast.children, 0), "operation")
    literal_node = get_node_with_tag(return_node, "literal")
    literal = literal_node.token.expression

    string = """
    .section .data
    .section .text
    .global _main
    _main:
      mov $#{literal},%rax
      ret

    """
    string
  end

  def get_node_with_tag(root, str_tag) do
    Enum.find(root.children, fn x -> x.tag == str_tag end)
  end
end