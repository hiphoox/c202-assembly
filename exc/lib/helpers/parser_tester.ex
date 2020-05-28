defmodule Helpers.ParserTester do 
  def get_c_structures_content() do
    """
    [
      %Structs.Node{
        asm: "movl %:5, %:r",
        children: [
          %{"class" => "data-type", "tag" => "data-type"},
          %{"class" => "function-name", "tag" => "function-name"},
          %{"class" => "args-opener", "tag" => "args-open"},
          %{"class" => "args-closer", "tag" => "args-close"},
          %{"class" => "function-opener", "tag" => "opener"},
          %{"class" => "operation", "tag" => "body"},
          %{"class" => "function-closer", "tag" => "closer"}
        ],
        class: "program-root",
        tag: "function",
        token: nil
      },
      %Structs.Node{
        asm: "",
        children: [],
        class: "data-type",
        tag: "int-data-type",
        token: "int"
      },
      %Structs.Node{
        asm: "",
        children: [],
        class: "function-name",
        tag: "main-function-name",
        token: "main"
      },
      %Structs.Node{
        asm: "",
        children: [],
        class: ["group-opener", "args-opener"],
        tag: "evaluator-open",
        token: "parenthesis-open"
      },
      %Structs.Node{
        asm: "",
        children: [],
        class: ["group-closer", "args-closer"],
        tag: "evaluator-close",
        token: "parenthesis-close"
      },
      %Structs.Node{
        asm: "",
        children: [],
        class: "function-opener",
        tag: "section-open",
        token: "bracket-open"
      },
      %Structs.Node{
        asm: "",
        children: [],
        class: "function-closer",
        tag: "section-close",
        token: "bracket-close"
      },
      %Structs.Node{
        asm: "movl %:1, %:r",
        children: [
          %{"class" => "return-word", "tag" => "return"},
          %{"class" => "high-evaluation", "tag" => "evaluation"},
          %{"class" => "line-ender", "tag" => "semicolon"}
        ],
        class: ["operation", "returner"],
        tag: "operation",
        token: nil
      },
      %Structs.Node{
        asm: "",
        children: [],
        class: "return-word",
        tag: "return-word",
        token: "return"
      },
      %Structs.Node{
        asm: "addl %:2, %:r",
        children: [
          %{"class" => "mid-evaluation", "tag" => "first-value"},
          %{"class" => "sum-operator", "tag" => "sum-operator"},
          %{"class" => "high-evaluation", "tag" => "second-value"}
        ],
        class: "high-evaluation",
        tag: "sum-operation",
        token: nil
      },
      %Structs.Node{
        asm: "subl %:2, %:r",
        children: [
          %{"class" => "mid-evaluation", "tag" => "first-value"},
          %{"class" => "minus-operator", "tag" => "minus-operator"},
          %{"class" => "high-evaluation", "tag" => "second-value"}
        ],
        class: "high-evaluation",
        tag: "minus-operation",
        token: nil
      },
      %Structs.Node{
        asm: "mov %:0, %:r",
        children: [%{"class" => "mid-evaluation", "tag" => "value"}],
        class: "high-evaluation",
        tag: "high-evaluation",
        token: nil
      },
      %Structs.Node{
        asm: "cdq\nidivl %:r",
        children: [
          %{"class" => "low-evaluation", "tag" => "first-value"},
          %{"class" => "division-operator", "tag" => "division-operator"},
          %{"class" => "mid-evaluation", "tag" => "second-value"}
        ],
        class: "mid-evaluation",
        tag: "division-operation",
        token: nil
      },
      %Structs.Node{
        asm: "imul %:0, %:r",
        children: [
          %{"class" => "low-evaluation", "tag" => "first-value"},
          %{
            "class" => "multiplication-operator",
            "tag" => "multiplication-operator"
          },
          %{"class" => "mid-evaluation", "tag" => "second-value"}
        ],
        class: "mid-evaluation",
        tag: "multiplication-operation",
        token: nil
      },
      %Structs.Node{
        asm: "mov %:0, %:r",
        children: [%{"class" => "low-evaluation", "tag" => "value"}],
        class: "mid-evaluation",
        tag: "mid-evaluation",
        token: nil
      },
      %Structs.Node{
        asm: "movl %:1, %:r",
        children: [
          %{"class" => "group-opener", "tag" => "group-open"},
          %{"class" => "high-evaluation", "tag" => "evaluation"},
          %{"class" => "group-closer", "tag" => "group-close"}
        ],
        class: "low-evaluation",
        tag: "grouped-operation",
        token: nil
      },
      %Structs.Node{
        asm: "neg %:1\nmovl %:1, %:r",
        children: [
          %{"class" => "negative-operator", "tag" => "operator"},
          %{"class" => "low-evaluation", "tag" => "evaluation"}
        ],
        class: "low-evaluation",
        tag: "negative-operation",
        token: nil
      },
      %Structs.Node{
        asm: "not %:1\nmovl %:1, %:r",
        children: [
          %{"class" => "complement-operator", "tag" => "operator"},
          %{"class" => "low-evaluation", "tag" => "evaluation"}
        ],
        class: "low-evaluation",
        tag: "complement-operation",
        token: nil
      },
      %Structs.Node{
        asm: "notl %:1\nmovl %:1, %:r",
        children: [
          %{"class" => "negation-operator", "tag" => "operator"},
          %{"class" => "low-evaluation", "tag" => "evaluation"}
        ],
        class: "low-evaluation",
        tag: "negation-operation",
        token: nil
      },
      %Structs.Node{
        asm: "movl $:t, %:r",
        children: [],
        class: "low-evaluation",
        tag: "literal",
        token: "literal"
      },
      %Structs.Node{
        asm: "",
        children: [],
        class: "line-ender",
        tag: "semicolon",
        token: "semicolon"
      },
      %Structs.Node{
        asm: "",
        children: [],
        class: ["negative-operator", "minus-operator"],
        tag: "minus",
        token: "minus"
      },
      %Structs.Node{
        asm: "",
        children: [],
        class: "complement-operator",
        tag: "complement",
        token: "complement"
      },
      %Structs.Node{
        asm: "",
        children: [],
        class: "negation-operator",
        tag: "negation",
        token: "negation"
      },
      %Structs.Node{
        asm: "",
        children: [],
        class: "sum-operator",
        tag: "sum",
        token: "plus"
      },
      %Structs.Node{
        asm: "",
        children: [],
        class: "division-operator",
        tag: "division",
        token: "slant"
      },
      %Structs.Node{
        asm: "",
        children: [],
        class: "multiplication-operator",
        tag: "multiplication",
        token: "asterix"
      }
    ]
    """
  end
end