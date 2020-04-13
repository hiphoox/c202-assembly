defmodule CodeGenerator do
  
  def generateCode(abstract_syntax_tree, verbose) do
    {raw_code, _result_my_context, _result_free_context} = generateRawStringCode(abstract_syntax_tree)
    raw_code |> rawCodeCleanup
    if verbose do
      #TODO: print ast
    end
  end

  defp generateRawStringCode(abstract_syntax_tree, incoming_free_context \\ getAvailableRegisters(), sibling_number \\ 0) do
    children_list = abstract_syntax_tree.children
    {children_string, children_context, free_context} = printNextChildren(children_list, [], incoming_free_context, 0, "")
    {return_string, return_my_context, return_free_context} = contextualizeASM(abstract_syntax_tree.asm, children_context, free_context, sibling_number)
    if abstract_syntax_tree.token == nil do
      {children_string <> return_string <> "\n", return_my_context, return_free_context}
    else
      {children_string <> String.replace(return_string, ":t", abstract_syntax_tree.token.expression) <> "\n", return_my_context, return_free_context}
    end
  end

  defp printNextChildren([], incoming_siblings_context, incoming_free_context, _sibling_number, incoming_string) do
    {incoming_string, incoming_siblings_context, incoming_free_context}
  end

  defp printNextChildren(children_list, incoming_siblings_context, incoming_free_context, sibling_number, incoming_string) do
    [head | tail] = children_list
    {return_string, return_siblings_context, return_free_context}  = generateRawStringCode(head, incoming_free_context, sibling_number)
    printNextChildren(tail, return_siblings_context ++ incoming_siblings_context, return_free_context, sibling_number + 1, return_string <> incoming_string)
  end

  defp getAvailableRegisters() do
    ["rbx", "rcx", "rdx", "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15"]
  end

  defp contextualizeASM(code, incoming_children_context, incoming_free_context, sibling_number) do
    #Find what registers I have to assign.
    register_candidates = Regex.scan(~r/:r|:v[0-9]+/, code) |> Enum.uniq |> List.flatten
    register_identities = fetchRegisters(register_candidates, incoming_free_context)
    #Create a replacement rule list for the equivalencies for placeholder-registry
    replacement_list = incoming_children_context ++ Enum.zip(register_candidates,register_identities)
    #Replace placeholders in string
    replaced_code = Enum.reduce_while(replacement_list, code, fn {k,v}, acc -> {:cont, String.replace(acc,k,v)} end)
    #Free children registers
    result_registry = Enum.into(replacement_list, %{})[":r"]
    canonical_registers = getAvailableRegisters() #Get legal registers
    new_free_registers = ( MapSet.intersection(canonical_registers |> MapSet.new ,Enum.map(incoming_children_context, fn {_x,y} -> y end) |> MapSet.new ) |> MapSet.to_list ) ++ Enum.filter(incoming_free_context, fn x -> x != result_registry end) 
    #Generate my return register equivalency
    my_register = [{":#{sibling_number}", if result_registry == nil do "" else  result_registry end}]
    #Return tuple
    {replaced_code, my_register, new_free_registers}
  end

  defp fetchRegisters([],_free_registers) do
    []
  end

  defp fetchRegisters(candidates,free_registers) do
    free_count = free_registers |> Enum.count
    need_count = candidates |> Enum.count
    Enum.slice(free_registers, 0..need_count-1) ++ generateRAMVariables(need_count-free_count)
  end

  defp generateRAMVariables(_number_needed) do
    []#TODO Implement this or it will fail someday
  end

  defp rawCodeCleanup(code) do
    Regex.replace(~r/\n+/, code, "\n")
  end
end
