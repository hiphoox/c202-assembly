defmodule Invoker do
    def invoke_gcc(file) do
        bfn = Path.basename(file, ".s")
        System.cmd("gcc", [file, "-o#{bfn}"])
    end
end
