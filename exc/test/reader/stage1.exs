defmodule StageOneReader do
  use ExUnit.Case

  test "001_S1_Valid_Return0" do
      scs = """
      int main() {
      \treturn 0;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() {  return 0; }"
  end

end