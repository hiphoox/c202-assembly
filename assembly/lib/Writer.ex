defmodule Writer do
    def write_file(code) do
        route = "assembly/code.s"
        File.write(route, code)
        Invoker.invoke_gcc(route)
    end
end