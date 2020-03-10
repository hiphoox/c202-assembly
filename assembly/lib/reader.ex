defmodule Reader do
    def load(file_path) do
        File.read!(file_path)
        |> generate_scs()
        |> IO.inspect()
    end

    def generate_scs(file_content) do
        String.trim(file_content)
    end
end