defmodule Helpers.Lt do
    @moduledoc false
    
    def get_c_tokens_content() do
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
            <token tag="minus">
                <expression>
                    -
                </expression>
            </token>
            <token tag="negation">
                <expression>
                    !
                </expression>
            </token>
            <token tag="complement">
                <expression>
                    ~
                </expression>
            </token>
            <token tag="plus">
                <expression>
                    \+
                </expression>
            </token>
            <token tag="asterix">
                <expression>
                    \*
                </expression>
            </token>
            <token tag="slant">
                <expression>
                    /
                </expression>
            </token>
        </token-list>
        """
    end

    def update_otl(otl, token, index \\ 6) do
        List.update_at(otl, index, fn _ -> token end)
    end
end