defmodule Helpers.GeneralTester do
    @moduledoc false

    def insert_token_list(output_token_list, [], _index) do
        output_token_list
    end

    def insert_token_list(output_token_list, list, index) do
        {token, list} = List.pop_at(list, 0)
        otl = List.insert_at(output_token_list, index, token)
        insert_token_list(otl, list, index + 1)
    end
    
    def delete_token_from_otl(output_token_list, index) do
        List.delete_at(output_token_list, index)
    end
    
    def get_c_tokens_content() do
        """
        <?xml version="1.0"?>
        <token-list>
            <token tag="int">
                <expression>
                    int\\s+
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
                    return\\s+
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
                    \\+
                </expression>
            </token>
            <token tag="asterix">
                <expression>
                    \\*
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

    def get_c_structures_content() do 
        """
        <?xml version="1.0"?>
        <structure-list>
            <structure tag="function">
                <token>
                </token>
                <substructure tag="data-type">
                        <class>data-type</class>
                </substructure>
                <substructure tag="function-name">
                        <class>function-name</class>
                </substructure>
                <substructure tag="args-open">
                    <class>args-opener</class>
                </substructure>
                <substructure tag="args-close">
                    <class>args-closer</class>
                </substructure>
                <substructure tag="opener">
                    <class>function-opener</class>
                </substructure>
                <substructure tag="body">
                    <class>operation</class>
                </substructure>
                <substructure tag="closer">
                    <class>function-closer</class>
                </substructure>
                <class>program-root</class>
                <asm>
                    movq %:5, %:r
                </asm>
            </structure>
            <structure tag="int-data-type">
                <token>
                    int
                </token>
                <class>data-type</class>
                <asm></asm>
            </structure>
            <structure tag="main-function-name">
                <token>
                    main
                </token>
                <class>function-name</class>
                <asm></asm>
            </structure>
            <structure tag="evaluator-open">
                <token>
                    parenthesis-open
                </token>
                <class>group-opener</class>
                <class>args-opener</class>
                <asm></asm>
            </structure>
            <structure tag="evaluator-close">
                <token>
                    parenthesis-close
                </token>
                <class>group-closer</class>
                <class>args-closer</class>
                <asm></asm>
            </structure>
            <structure tag="section-open">
                <token>
                    bracket-open
                </token>
                <class>function-opener</class>
                <asm></asm>
            </structure>
            <structure tag="section-close">
                <token>
                    bracket-close
                </token>
                <class>function-closer</class>
                <asm></asm>
            </structure>
            <structure tag="operation">
                <token>
                </token>
                <substructure tag="return">
                    <class>return-word</class>
                </substructure>
                <substructure tag="evaluation">
                    <class>high-evaluation</class>
                </substructure>
                <substructure tag="semicolon">
                    <class>line-ender</class>
                </substructure>
                <class>operation</class>
                <class>returner</class>
                <asm>
                movq %:1, %:r
                </asm>
            </structure>
            <structure tag="return-word">
                <token>
                    return
                </token>
                <class>return-word</class>
                <asm>
                </asm>
            </structure>
            <structure tag="sum-operation">
                <token></token>
                <substructure tag="first-value">
                    <class>mid-evaluation</class>
                </substructure>
                <substructure tag="sum-operator">
                    <class>sum-operator</class>
                </substructure>
                <substructure tag="second-value">
                    <class>high-evaluation</class>
                </substructure>
                <class>high-evaluation</class>
                <asm>
                movq %:0, %:r
                add %:2, %:r
                </asm>
            </structure>
            <structure tag="minus-operation">
                <token></token>
                <substructure tag="first-value">
                    <class>mid-evaluation</class>
                </substructure>
                <substructure tag="minus-operator">
                    <class>minus-operator</class>
                </substructure>
                <substructure tag="second-value">
                    <class>high-evaluation</class>
                </substructure>
                <class>high-evaluation</class>
                <asm>
                movq %:0, %:r
                sub %:2, %:r
                </asm>
            </structure>
            <structure tag="high-evaluation">
                <token></token>
                <substructure tag="value">
                    <class>mid-evaluation</class>
                </substructure>
                <class>high-evaluation</class>
                <asm>
                movq %:0, %:r
                </asm>
            </structure>
            <structure tag="division-operation">
                <token></token>
                <substructure tag="first-value">
                    <class>low-evaluation</class>
                </substructure>
                <substructure tag="division-operator">
                    <class>division-operator</class>
                </substructure>
                <substructure tag="second-value">
                    <class>mid-evaluation</class>
                </substructure>
                <class>mid-evaluation</class>
                <asm>
                movq %:0, %rax
                movq $0, %rdx
                idiv %:2
                movq %rax, %:r
                </asm>
            </structure>
            <structure tag="multiplication-operation">
                <token></token>
                <substructure tag="first-value">
                    <class>low-evaluation</class>
                </substructure>
                <substructure tag="multiplication-operator">
                    <class>multiplication-operator</class>
                </substructure>
                <substructure tag="second-value">
                    <class>mid-evaluation</class>
                </substructure>
                <class>mid-evaluation</class>
                <asm>
                movq %:0, %:r
                imul %:2, %:r
                </asm>
            </structure>
            <structure tag="mid-evaluation">
                <token></token>
                <substructure tag="value">
                    <class>low-evaluation</class>
                </substructure>
                <class>mid-evaluation</class>
                <asm>
                movq %:0, %:r
                </asm>
            </structure>
            <structure tag="grouped-operation">
                <token></token>
                <substructure tag="group-open">
                    <class>group-opener</class>
                </substructure>
                <substructure tag="evaluation">
                    <class>high-evaluation</class>
                </substructure>
                <substructure tag="group-close">
                    <class>group-closer</class>
                </substructure>
                <class>low-evaluation</class>
                <asm>
                movq %:1, %:r
                </asm>
            </structure>
            <structure tag="negative-operation">
                <token></token>
                <substructure tag="operator">
                    <class>negative-operator</class>
                </substructure>
                <substructure tag="evaluation">
                    <class>low-evaluation</class>
                </substructure>
                <class>low-evaluation</class>
                <asm>
                    neg %:1
        movq %:1, %:r
                </asm>
            </structure>
            <structure tag="complement-operation">
                <token></token>
                <substructure tag="operator">
                    <class>complement-operator</class>
                </substructure>
                <substructure tag="evaluation">
                    <class>low-evaluation</class>
                </substructure>
                <class>low-evaluation</class>
                <asm>
                    not %:1
        movq %:1, %:r
                </asm>
            </structure>
            <structure tag="negation-operation">
                <token></token>
                <substructure tag="operator">
                    <class>negation-operator</class>
                </substructure>
                <substructure tag="evaluation">
                    <class>low-evaluation</class>
                </substructure>
                <class>low-evaluation</class>
                <asm>
                    not %:1
        movq %:1, %:r
                </asm>
            </structure>
            <structure tag="literal">
                <token>
                    literal
                </token>
                <class>low-evaluation</class>
                <asm>
                    movq $:t, %:r
                </asm>
            </structure>
            <structure tag="semicolon">
                <token>
                    semicolon
                </token>
                <class>line-ender</class>
                <asm></asm>
            </structure>
            <structure tag="minus">
                <token>
                    minus
                </token>
                <class>negative-operator</class>
                <class>minus-operator</class>
                <asm></asm>
            </structure>
            <structure tag="complement">
                <token>
                    complement
                </token>
                <class>complement-operator</class>
                <asm></asm>
            </structure>
            <structure tag="negation">
                <token>
                    negation
                </token>
                <class>negation-operator</class>
                <asm></asm>
            </structure>
                <structure tag="sum">
                <token>
                    plus
                </token>
                <class>sum-operator</class>
                <asm></asm>
            </structure>
            <structure tag="division">
                <token>
                    slant
                </token>
                <class>division-operator</class>
                <asm></asm>
            </structure>
            <structure tag="multiplication">
                <token>
                    asterix
                </token>
                <class>multiplication-operator</class>
                <asm></asm>
            </structure>
        </structure-list>
        """
    end    
end