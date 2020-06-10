defmodule GeneralTester do
  @moduledoc """
  Module used to perform general tests.
  """

  def insert_token_list(output_token_list, [], _index)        do
    output_token_list
  end

  def insert_token_list(output_token_list, list, index)       do
    {token, list} = List.pop_at(list, 0)
    otl = List.insert_at(output_token_list, index, token)
    insert_token_list(otl, list, index + 1)
  end

  def delete_token_from_otl(output_token_list, index)         do
    List.delete_at(output_token_list, index)
  end

  def start_general_test_compilation(source_code_string)      do
    general_abstract_syntax_tree = get_c_structures_content()
    |> Reader._generate_general_ast()
    general_token_list = get_c_tokens_content()
    |> Reader._generate_general_token_list()
    {output_token_list, lexer_token} = 
      Lexer.tokenize({source_code_string, general_token_list})

    case lexer_token do
      :error -> Common.StringElements.lexer_error_invalid_token()
      :ok -> evaluate_parser(output_token_list, general_abstract_syntax_tree)
    end
  end

  defp evaluate_parser(output_token_list, general_abstract_syntax_tree) do 
    {parser_token,output_abstract_syntax_tree,_token_list,_error_cause} = 
      Parser.parse(output_token_list, general_abstract_syntax_tree)
    case parser_token do 
      :token_missing_error -> Common.StringElements.parser_error_missing_token()
      :token_not_absorbed_error -> Common.StringElements.parser_error_token_not_absorbed()
      :ok -> continue_from_parser(output_abstract_syntax_tree)
    end
  end

  defp continue_from_parser(output_abstract_syntax_tree) do 
    CodeGenerator.generate_code(output_abstract_syntax_tree, false)
    |> CodeOptimizer.optimize(false)
    |> CodeConnector.connect(false)
    |> Writer.write_file()
    |> Invoker.invoke_gcc("")
  end

  def get_c_tokens_content()                                  do
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
        <token tag="and">
            <expression>
                \\&amp;\\&amp;
            </expression>
        </token>
        <token tag="or">
            <expression>
                \\|\\|
            </expression>
        </token>
        <token tag="neq">
            <expression>
                !=
            </expression>
        </token>
        <token tag="negation">
            <expression>
                !
            </expression>
        </token>
        <token tag="eq">
            <expression>
                ==
            </expression>
        </token>
        <token tag="leq">
            <expression>
                &lt;=
            </expression>
        </token>
        <token tag="le">
            <expression>
                &lt;
            </expression>
        </token>
        <token tag="geq">
            <expression>
                &gt;=
            </expression>
        </token>
        <token tag="ge">
            <expression>
                &gt;
            </expression>
        </token>
    </token-list>
    """
  end

  def get_c_structures_content()                             do
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
                <class>exp</class>
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
        <structure tag="logical-or-operation">
          <token></token>
          <substructure tag="first-value">
            <class>logical-and-exp</class>
          </substructure>
          <substructure tag="logical-or-operator">
            <class>logical-or-operator</class>
          </substructure>
          <substructure tag="second-value">
            <class>exp</class>
          </substructure>
          <class>
            exp  
          </class>
          <asm>
            cmp $0, %:0
            je _:uclause2
            movq $1, %:r
            jmp _:uend
        _:uclause2:
            cmp $0, %:2
            movq $0, %rax
            setne %al
            movq %rax, %:r
        _:uend:
          </asm>
        </structure>

        <structure tag="logical-and-operation">
          <token></token>
          <substructure tag="first-value">
            <class>equality-exp</class>
          </substructure>
          <substructure tag="logical-and-operator">
            <class>logical-and-operator</class>
          </substructure>
          <substructure tag="second-value">
            <class>logical-and-exp</class>
          </substructure>
          <class>
            logical-and-exp
          </class>
          <asm>
            cmp $0, %:0
            jne _:uclause2
            movq $0, %:r
            jmp _:uend
        _:uclause2:
            cmp $0, %:2
            movq $0, %rax
            setne %al
            movq %rax, %:r
        _:uend:
          </asm>
        </structure>


        <structure tag="not-equal-operation">
          <token></token>
          <substructure tag="first-value">
            <class>relational-exp</class>
          </substructure>
          <substructure tag="not-equal-operator">
            <class>not-equal-operator</class>
          </substructure>
          <substructure tag="second-value">
            <class>equality-exp</class>
          </substructure>
          <class>
            equality-exp
          </class>
          <asm>
            cmp %:0, %:2
            mov $0, %rax
            setne %al
            movq %rax, %:r
          </asm>
        </structure>
        <structure tag="equal-operation">
          <token></token>
          <substructure tag="first-value">
            <class>relational-exp</class>
          </substructure>
          <substructure tag="equal-operator">
            <class>equal-operator</class>
          </substructure>
          <substructure tag="second-value">
            <class>equality-exp</class>
          </substructure>
          <class>
            equality-exp
          </class>
          <asm>
            cmp %:0, %:2
            mov $0, %rax
            sete %al
            movq %rax, %:r
          </asm>
        </structure>


        <structure tag="less-than-operation">
          <token></token>
          <substructure tag="first-value">
            <class>additive-exp</class>
          </substructure>
          <substructure tag="less-than-operator">
            <class>le-operator</class>
          </substructure>
          <substructure tag="second-value">
            <class>relational-exp</class>
          </substructure>
          <class>
            relational-exp
          </class>
          <asm>
            cmp %:2, %:0
            movq $0, %rax
            setl %al
            movq %rax, %:r
          </asm>
        </structure>
        
        <structure tag="greater-than-opearation">
          <token></token>
          <substructure tag="first-value">
            <class>additive-exp</class>
          </substructure>
          <substructure tag="greater-than-operator">
            <class>ge-operator</class>
          </substructure>
          <substructure tag="second-value">
            <class>relational-exp</class>
          </substructure>
          <class>
            relational-exp
          </class>
          <asm>
            cmp %:2, %:0
            movq $0, %rax
            setg %al
            movq %rax, %:r
          </asm>
        </structure>

        <structure tag="less-than-or-equal-to-operation">
          <token></token>
          <substructure tag="first-value">
            <class>additive-exp</class>
          </substructure>
          <substructure tag="less-than-or-equal-operator">
            <class>leq-operator</class>
          </substructure>
          <substructure tag="second-value">
            <class>relational-exp</class>
          </substructure>
          <class>
            relational-exp
          </class>
          <asm>
            cmp %:2, %:0
            movq $0, %rax
            setle %al
            movq %rax, %:r
          </asm>
        </structure>

        <structure tag="greater-than-or-equal-to-operation">
          <token></token>
          <substructure tag="first-value">
            <class>additive-exp</class>
          </substructure>
          <substructure tag="greater-than-or-equal-to-operator">
            <class>geq-operator</class>
          </substructure>
          <substructure tag="second-value">
            <class>relational-exp</class>
          </substructure>
          <class>
            relational-exp
          </class>
          <asm>
            cmp %:2, %:0
            movq $0, %rax
            setge %al
            movq %rax, %:r
          </asm>
        </structure>
        

        <structure tag="sum-operation">
            <token></token>
            <substructure tag="first-value">
                <class>term</class>
            </substructure>
            <substructure tag="sum-operator">
                <class>sum-operator</class>
            </substructure>
            <substructure tag="second-value">
                <class>additive-exp</class>
            </substructure>
            <class>additive-exp</class>
            <asm>
            movq %:0, %:r
          add %:2, %:r
          </asm>
        </structure>
        <structure tag="minus-operation">
            <token></token>
            <substructure tag="first-value">
                <class>term</class>
            </substructure>
          <substructure tag="minus-operator">
                <class>minus-operator</class>
            </substructure>
            <substructure tag="second-value">
                <class>additive-exp</class>
          </substructure>
            <class>additive-exp</class>
            <asm>
            movq %:0, %:r
          sub %:2, %:r
          </asm>
        </structure>


        <structure tag="division-operation">
            <token></token>
            <substructure tag="first-value">
                <class>factor</class>
            </substructure>
            <substructure tag="division-operator">
                <class>division-operator</class>
            </substructure>
            <substructure tag="second-value">
                <class>term</class>
            </substructure>
            <class>term</class>
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
                <class>factor</class>
            </substructure>
            <substructure tag="multiplication-operator">
                <class>multiplication-operator</class>
            </substructure>
            <substructure tag="second-value">
                <class>term</class>
            </substructure>
            <class>term</class>
            <asm>
            movq %:0, %:r
          imul %:2, %:r
          </asm>
        </structure>


        <structure tag="negative-operation">
            <token></token>
          <substructure tag="operator">
                <class>negative-operator</class>
            </substructure>
            <substructure tag="evaluation">
                <class>factor</class>
            </substructure>
            <class>factor</class>
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
                <class>factor</class>
            </substructure>
            <class>factor</class>
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
                <class>factor</class>
            </substructure>
            <class>factor</class>
            <asm>
              cmp $0, %:1
              movq $0, %rax
              sete %al
              movq %rax, %:r
          </asm>
        </structure>


        <structure tag="exp">
          <token></token>
          <substructure tag="value">
            <class>logical-and-exp</class>
          </substructure>
          <class>
            exp
          </class>
          <asm>
          movq %:0, %:r
          </asm>
        </structure>
        <structure tag="logical-and-exp">
          <token></token>
          <substructure tag="value">
            <class>equality-exp</class>
          </substructure>
          <class>
            logical-and-exp
          </class>
          <asm>
          movq %:0, %:r
          </asm>
        </structure>
        <structure tag="equality-exp">
          <token></token>
          <substructure tag="value">
            <class>relational-exp</class>
          </substructure>
          <class>
            equality-exp
          </class>
          <asm>
          movq %:0, %:r
          </asm>
        </structure>
        <structure tag="relational-exp">
          <token></token>
          <substructure tag="value">
            <class>additive-exp</class>
          </substructure>
          <class>
            relational-exp
          </class>
          <asm>
          movq %:0, %:r
          </asm>
        </structure>
        <structure tag="additive-exp">
            <token></token>
            <substructure tag="value">
                <class>term</class>
            </substructure>
            <class>additive-exp</class>
            <asm>
          movq %:0, %:r
          </asm>
        </structure>
        <structure tag="term">
            <token></token>
            <substructure tag="value">
                <class>factor</class>
            </substructure>
            <class>term</class>
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
                <class>exp</class>
            </substructure>
            <substructure tag="group-close">
                <class>group-closer</class>
            </substructure>
            <class>factor</class>
            <asm>
          movq %:1, %:r
          </asm>
        </structure>


        <structure tag="literal">
            <token>
                literal
            </token>
            <class>factor</class>
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
        <structure tag="logical-or">
            <token>
                or
            </token>
            <class>logical-or-operator</class>
            <asm></asm>
        </structure>
        <structure tag="logical-and">
            <token>
                and
            </token>
            <class>logical-and-operator</class>
            <asm></asm>
        </structure>
        <structure tag="not-equal">
            <token>
                neq
            </token>
            <class>not-equal-operator</class>
            <asm></asm>
        </structure>
        <structure tag="equal">
            <token>
                eq
            </token>
            <class>equal-operator</class>
            <asm></asm>
        </structure>
        <structure tag="less-than">
            <token>
                le
            </token>
            <class>le-operator</class>
            <asm></asm>
        </structure>
        <structure tag="less-than-or-equal">
            <token>
                leq
            </token>
            <class>leq-operator</class>
            <asm></asm>
        </structure>
        <structure tag="greater-than">
            <token>
                ge
            </token>
            <class>ge-operator</class>
            <asm></asm>
        </structure>
        <structure tag="greater-than-or-equal">
            <token>
                geq
            </token>
            <class>geq-operator</class>
            <asm></asm>
        </structure>
    </structure-list>
    """
  end
end
