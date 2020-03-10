defmodule Reader do
    def load(file_path) do
        File.read!(file_path)
        |> generate_scs()
    end

    def generate_scs(file_content)
        String.trim(content)
    end
end