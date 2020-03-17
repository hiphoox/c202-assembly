defmodule Writer do
    def write_file(code) do
        route = "assembly/code.s"
        File.write(route, code)
        route
    end
end