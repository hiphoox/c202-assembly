<<<<<<< HEAD:assembly/lib/CodeGenerator.ex
defmodule CodeGenerator do
  #No me deja poner la primera en minúscula
=======
defmodule code_generator do

>>>>>>> 5aca6f0482a1bcfa84654eea3cd01ed60d963595:assembly/lib/code_generator.ex
  def generate_code(oast) do
    return_node = get_node_with_tag(Enum.at(oast.children, 0), "operation")
    literal_node = get_node_with_tag(return_node, "literal")
    literal = literal_node.token.expression

    string = """
      .section        __TEXT,__text,regular,pure_instructions
      .p2align        4, 0x90
      .globl _main
    _main:
      movl $#{literal},%eax
      ret
    """
    string
  end

  def get_node_with_tag(root, str_tag) do
    Enum.find(root.children, fn x -> x.tag == str_tag end)
  end
end
