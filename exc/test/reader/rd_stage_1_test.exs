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
  
  test "002_S1_Valid_Return7" do
      scs = """
      int main() {
      \treturn 7;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() {  return 7; }"
  end
  
  test "003_S1_Valid_ReturnMD130" do
      scs = """
      int main() {
      \treturn 130;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() {  return 130; }"
  end
  
  test "004_S1_Valid_ReturnBlankSpaces" do
      scs = """
      int
      main
      (
      )
      {
      return
      1
      ;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main ( ) { return 1 ; }"
  end

end