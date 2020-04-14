defmodule Helpers.Lt do
    @moduledoc false
    
    def get_gtl_content() do
        """
        <?xml version="1.0"?>
        <token-list>
            <token tag="int">
                <expression>
                    int\s+
                </expression>
            </token>
            <token tag="main">
                <expression>
                    main
                </expression>
            </token>
            <token tag="parenthesis-open">
                <expression>
                    \\(
                </expression>
            </token>
            <token tag="parenthesis-close">
                <expression>
                    \\)
                </expression>
            </token>
            <token tag="bracket-open">
                <expression>
                    {
                </expression>
            </token>
            <token tag="bracket-close">
                <expression>
                    }
                </expression>
            </token>
            <token tag="return">
                <expression>
                    return\s+
                </expression>
            </token>
            <token tag="literal">
                <expression>
                    [0-9]+
                </expression>
            </token>
            <token tag="semicolon">
                <expression>
                    ;
                </expression>
            </token>
            <token tag="error">
                <expression>
                    \\S+
                </expression>
            </token>
        </token-list>
        """
    end
    def update_otl(otl, token, index \\ 6) do
        List.update_at(otl, index, fn _ -> token end)
    end
end