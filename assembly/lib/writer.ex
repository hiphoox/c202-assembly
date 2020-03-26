defmodule writer do
    def write_file(code) do
        route = "./code.s"
        File.write(route, code)
        route
    end
end
