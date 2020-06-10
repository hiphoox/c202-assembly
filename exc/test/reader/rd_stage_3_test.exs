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
  
  test "002_S3_Valid_SubstractPositive" do
      scs = """
      int main() {
      \treturn 4 - 17;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() {  return 4 - 17; }"
  end
  
  test "003_S3_Valid_SubstractNegative" do
      scs = """
      int main() {
      \treturn -7 - -8;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() {  return -7 - -8; }"
  end
  
  test "004_S3_Valid_DivPositive" do
      scs = """
      int main() {
      \treturn 18 / 3;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() {  return 18 / 3; }"
  end
  
  test "005_S3_Valid_DivNegative" do
      scs = """
      int main() {
      \treturn -8 / -4;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() {  return -8 / -4; }"
  end
  
  test "006_S3_Valid_MultPositive" do
      scs = """
      int main() {
      \treturn 11 * 17;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() {  return 11 * 17; }"
  end
  
   test "007_S3_Valid_MultNeg" do
      scs = """
      int main() {
      \treturn 5 * -13;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() {  return 5 * -13; }"
  end
  
  test "008_S3_Valid_SimpleParenthesis" do
      scs = """
      int main() {
      \treturn 2 * (5 + 3);
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() {  return 2 * (5 + 3); }"
  end
  
  test "009_S3_Valid_Precedence" do
      scs = """
      int main() {
      \treturn 2 * 5 + 21 / 9;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() {  return 2 * 5 + 21 / 9; }"
  end
  
  test "010_S3_Valid_Bitwise_NoParenthesis" do
      scs = """
      int main() {
      \treturn ~7 - 4;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() {  return ~7 - 4; }"
  end
  
  test "011_S3_Valid_Bitwise_Parenthesis" do
      scs = """
      int main() {
      \treturn ~(7 + 4);
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() {  return ~(7 + 4); }"
  end
  
  test "012_S3_Invalid_Div_Missing_Operator" do
      scs = """
      int main() {
      \treturn 3 / ;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() {  return 3 / ; }"
  end
  
  test "013_S3_Invalid_Sum_Missing_Operator" do
      scs = """
      int main() {
      \treturn 7 + ;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() {  return 7 + ; }"
  end
  
  test "014_S3_Invalid_Parenthesis_Middle_Operator" do
      scs = """
      int main() {
      \treturn (6 + 4) 10;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() {  return (6 + 4) 10; }"
  end
  
  test "015_S3_Invalid_Neg_Missing_Operator" do
      scs = """
      int main() {
      \treturn (6 + 4) -;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() {  return (6 + 4) -; }"
  end

end