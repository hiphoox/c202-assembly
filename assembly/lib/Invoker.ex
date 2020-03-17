defmodule Invoker do
    def invoke_gcc(file) do
        generate_code_object = "gcc -o a"<>file
        System.cmd(generate_code_object,[])
    end
end