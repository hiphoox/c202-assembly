defmodule CodeOptimizer do

    def optimize(code) do
        code |>
        String.split("\n") |>
        optimize_movq |>
        Enum.join("\n")
    end

    defp optimize_movq(code) do
        [head | tail] = code
        if tail == [] do
            []
        else
            if is_movq?(head) == false do
                [head] ++ optimize_movq(tail)
            else
                [reg_a, reg_b] = get_registers(head)
                if reg_a == reg_b do
                    optimize_movq(tail)
                else
                    if is_exclusive_register?(reg_b) == false do
                   {new_reg_b, new_tail} = seek_next_movq(reg_b, tail)
                   new_head = "    movq " <> reg_a <> ", " <> new_reg_b
                    if new_reg_b == reg_b do#no hicimos nada al final
                        [new_head] ++ optimize_movq(new_tail)
                    else
                        optimize_movq([new_head] ++ new_tail)
                    end
                else#el registro mueve e rax, y eso es importante por lo que no lo podemos optimizar 
                    [head] ++ optimize_movq(tail)
                end
                end
            end
        end
    end

    defp optimize_exclusive_registers(code) do
        2
    end

    defp seek_next_movq(reg_b, []) do
        {reg_b, []}
    end
    
    defp seek_next_movq(reg_b, code) do
        [head | tail] = code
        registers = get_registers(head)
        if Enum.member?(registers, reg_b) do
            if is_movq?(head) do
                [_cand_a, cand_b] = registers
                if cand_b == reg_b do
                    {reg_b, code}
                else
                    if is_exclusive_register?(cand_b) do
                        {reg_b, code}
                    else
                        {cand_b, tail}
                    end
                end
            else
                if instruction_has_side_effects?(head)do
                    {reg_b, code}
                else
                    {new_reg_b, new_tail} = seek_next_movq(reg_b, tail)
                    {new_reg_b, [String.replace(head,reg_b, new_reg_b)] ++ new_tail}
                end
            end
        else
            {new_reg_b, new_tail} = seek_next_movq(reg_b, tail)
            if instruction_has_side_effects?(head) and Enum.member?(registers, new_reg_b) do
                    #{reg_b, code}
                    {reg_b, [head] ++ fix_involvement(reg_b,new_reg_b,tail)}#untested
                else
                    {new_reg_b, [head] ++ new_tail}
            end
        end

    end

    defp fix_involvement(_old_reg, _new_reg, []) do
        []
    end

    defp fix_involvement(old_reg, new_reg, code) do
        [head | tail] = code
        registers = get_registers(head)
        if instruction_has_side_effects?(head) and Enum.member?(registers, new_reg) do
            [a, _b]=registers
            if a == new_reg do
                [String.replace(head, new_reg, old_reg)] ++ tail
            else
                [String.replace(head, new_reg, old_reg)] ++ fix_involvement(old_reg, new_reg, tail)
            end
        else
            [String.replace(head, new_reg, old_reg)] ++ fix_involvement(old_reg, new_reg, tail)
        end
    end

    defp is_movq?(line) do
        String.match?(line, ~r/movq/)
    end

    defp is_exclusive_register?(reg) do
        Enum.member?(["%rax"], reg)
    end

    defp is_number?(reg) do
        String.match?(reg, ~r/$\w*/)
    end

    defp instruction_has_side_effects?(line) do
        String.match?(line, ~r/add|sub|imul|idiv/)
    end

    defp get_registers(line) do
        Regex.scan(~r/[%|$]\w*/, line) |> List.flatten
    end

end
