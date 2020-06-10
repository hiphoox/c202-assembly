defmodule CodeOptimizer do
    @moduledoc """
    Generate the code that will be shown on the screen.
    """

    @doc """
    ```code```  exit code of `CodeGenerator.generate_code/2`.
    ```verbose```  a boolean value indicating if the compiler should output all of its steps.
    """
    def optimize(code, verbose) do
        code
          |> String.split("\n")
          |> optimize_downwards
          |> Enum.join("\n")
          |> IO.Printer.check_for_verbose(verbose)
    end

    defp optimize_downwards([]) do
        []
    end

    defp optimize_downwards(code) do
        [head | tail] = code
        if tail == [] do
            []
        else
            if instruction_frees?(head) do #Instruction frees memory
                if is_idiv?(head) do
                    [head] ++ optimize_downwards(tail)
                else
                    [reg_a, reg_b] = get_registers(head) #All memory freeing instructions have 2 operands. Except for idiv
                    if instruction_frees_all?(head) do #cmp frees all
                        [head] ++ optimize_downwards(tail)
                    else#movq, imul, idiv, add, sub
                        if is_exclusive_register?(reg_b) and is_movq?(head) do
                            [head] ++ optimize_downwards(tail)
                        else
                            #IO.puts("OPTIMIZANDO")
                            #IO.puts(head)
                            {new_reg, new_tail} = seek_down(reg_b, tail)
                            #IO.puts("OPT - DONE")

                            if new_reg == reg_b or reg_a == new_reg do
                                if is_movq?(head) and reg_a == new_reg do
                                    #IO.puts("Eliminanting redundant movq.")
                                    optimize_downwards(new_tail)
                                else
                                    #IO.puts("a=b, not advancing in...")
                                    #IO.puts(head)
                                    if reg_a == new_reg do
                                        [head] ++ optimize_downwards(tail)
                                    else
                                        [head] ++ optimize_downwards(new_tail)
                                    end
                                end
                            else
                                #IO.puts("Optimized register is ...")
                                #IO.puts(String.replace(head, reg_b, new_reg))
                                optimize_downwards([String.replace(head, reg_b, new_reg)] ++ new_tail)

                            end
                        end
                    end
                end
            else
                [head] ++ optimize_downwards(tail)
            end
        end
    end

    defp seek_down(reg_b, []) do
        {reg_b, []}
    end

    defp seek_down(reg_b, code) do
        [head | tail] = code
        #IO.puts("EVALUATING")
        #IO.puts(head)
        registers = get_registers(head)
        if Enum.member?(registers, reg_b) do
            if instruction_frees?(head) do
                if is_idiv?(head) do
                    {reg_b,code}
                else
                    [a, b] = registers
                    if is_movq?(head) do
                        if a == reg_b do
                            #IO.puts("MOVQ REPLACED")
                            {b, tail}
                        else
                            #IO.puts("MOVQ KILLED ME")
                            #IO.puts(reg_b)
                            {reg_b, code}
                        end
                    else
                        if is_cmp?(head) do
                            #IO.puts("COMPARISON FOUND")
                            {reg_b,code}
                        else
                            if a == reg_b do
                                #IO.puts("REGISTRY DYING")
                                #IO.puts(reg_b)
                                {reg_b,code}
                            else
                                {new_reg, new_tail} = seek_down(reg_b, tail)
                                if a == new_reg do
                                    #IO.puts("CASCADING REGISTRY FAILED. CORRECTING.")
                                    {reg_b, code}
                                else
                                    #IO.puts("REGISTRY REPLACED")
                                    {new_reg, [String.replace(head, b, new_reg)] ++ new_tail}
                                end

                            end
                        end
                    end
                end
            else
                {new_reg, new_tail} = seek_down(reg_b, tail)
                {new_reg, [String.replace(head, reg_b, new_reg)] ++ new_tail}
            end
        else
            if is_end_tag?(head) do
                {reg_b, code}
            else
                {new_reg, new_tail} = seek_down(reg_b, tail)
                if Enum.member?(registers, new_reg) do
                    {reg_b, code}
                else
                    {new_reg, [head] ++ new_tail}
                end
            end
        end
    end


    defp is_end_tag?(line) do
        String.match?(line, ~r/end:/)
    end

    defp is_movq?(line) do
        String.match?(line, ~r/movq/)
    end

    defp is_exclusive_register?(reg) do
        Enum.member?(["%rax", "%rdx"], reg)
    end

    defp instruction_frees?(line) do
        String.match?(line, ~r/add|sub|imul|idiv|cmp|movq/)
    end

    defp is_idiv?(line) do
        String.match?(line, ~r/idiv/)
    end

    defp instruction_frees_all?(line) do
        String.match?(line, ~r/cmp/)
    end

    defp is_cmp?(line) do
        String.match?(line, ~r/cmp/)
    end

    defp get_registers(line) do
        Regex.scan(~r/[%|$]\w*/, line) |> List.flatten
    end
end
