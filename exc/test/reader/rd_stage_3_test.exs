defmodule StageThreeReader do
  use ExUnit.Case

  test "001_S3_Valid_Add" do
      scs = """
      int main() {
      \treturn 4 + 7;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() {  return 4 + 7; }"
  end

end