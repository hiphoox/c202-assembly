defmodule StageTwoReader do
  use ExUnit.Case

  test "001_S2_Valid_Negative" do
      scs = """
      int main() {
      \treturn -7;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() {  return -7; }"
  end
  
  test "002_S2_Valid_Bitwise" do
      scs = """
      int main(){
      return ~7;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main(){ return ~7; }"
  end

end