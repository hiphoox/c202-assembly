defmodule Reader do
    def load(file_path) do
        IO.puts File.read!(file_path)
    end
end