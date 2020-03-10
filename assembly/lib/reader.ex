defmodule Reader do
    
    @c_tokens_path "./specification_files/c_tokens.xml"
    @c_structures_path "./specification_files/c_structures.xml"

    def load(file_path)                   do
        scs = File.read!(file_path)
        # scs   |> IO.inspect()
        gtl = File.read!(@c_tokens_path)
              |> generate_gtl()
        # gtl   |> IO.inspect()
        gast = File.read!(@c_structures_path)
               |> generate_gast()
        # gast   |> IO.inspect()
        {scs, gtl, gast}
    end

    def generate_scs(file_content)        do
        clean_file_content(file_content)
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

    defp clean_file_content(file_content) do
        content = String.trim(file_content)
        Regex.replace(~r/\n/, content, " ")
    end

    defp parse_to_token_list(list)        do
        Enum.map list, fn(token) -> 
            %Structs.Token{
                tag:        token["tag"],
                expression: Regex.replace(~r/\'/,token["expression"],""),
                pos_y:      nil,
                pos_x:      nil,
            }
        end
    end

    defp parse_to_node_list(list)         do
        Enum.map list, fn(node) -> 
            %Structs.Node{
                tag:        node["tag"],
                token:      node["token"],
                children:   node["substructure"],
                class:      node["class"],
                asm:        node["asm"]
            }
        end
    end

    defp generate_useful_list(map)        do
        [general_list | _] = Map.values map
        [useful_list | _ ] = Map.values general_list
        useful_list
    end
end