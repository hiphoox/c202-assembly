defmodule Reader do
    def load(file_path) do
        File.read!(file_path)
        |> get_scs()
    end

    def get_scs(file_content)
        String.trim(content)
    end
end