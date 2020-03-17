defmodule Reader do
    
    @c_tokens_path "./specification_files/c_tokens.xml"
    @c_structures_path "./specification_files/c_structures.xml"

    def load(file_path)                   do
        scs = File.read!(file_path) |> generate_scs()
        gtl = File.read!(@c_tokens_path) |> generate_gtl()
        g = add_error_token(gtl)
        {scs, g}
    end

    def load_gast() do 
        File.read!(@c_structures_path) |> generate_gast()
    end

    def add_error_token(gtl)              do
        gtl ++ [%Structs.Token{tag: "error", expression: "\\S+", pos_y: nil, pos_x: nil}]
    end

    def generate_scs(file_content)        do
        String.trim(file_content)
        |> String.replace("\n", " ")
        |> String.replace("\t", " ")
    end

    def generate_gtl(file_content)        do
        XmlToMap.naive_map(file_content)
        |> generate_useful_list()
        |> parse_to_token_list()
    end

    def generate_gast(file_content)       do
        XmlToMap.naive_map(file_content) 
        |> generate_useful_list()
        |> parse_to_node_list()
    end

    defp parse_to_token_list(list)        do
        Enum.map list, fn(token) -> 
            %Structs.Token{
                tag:        token["tag"],
                expression: token["expression"],
                pos_y:      nil,
                pos_x:      nil,
            }
        end
    end

    defp parse_to_node_list(list)         do
        Enum.map list, fn(node) -> 
            %Structs.Node{
                tag:        node["tag"],
                token:      get_t(node),
                children:   get_c(node),
                class:      node["class"],
                asm:        get_asm(node)
            }
        end
    end

    def get_c(node) do 
        if node["substructure"] == nil, do: [], else: node["substructure"]
    end

    def get_t(node) do 
        if node["token"] == %{}, do: nil, else: node["token"]
    end

    def get_asm(node) do 
        if node["asm"] == %{}, do: "", else: node["asm"]
    end

    defp generate_useful_list(map)        do
        [general_list | _] = Map.values map
        [useful_list | _ ] = Map.values general_list
        useful_list
    end
end
