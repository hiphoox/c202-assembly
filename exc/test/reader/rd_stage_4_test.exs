defmodule StageFourReader do
  use ExUnit.Case

  test "001_S4_Valid_AND_Boolean_False" do
      scs = """
      int main() {
      \treturn 7 && 4;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 7 && 4; }"
  end
  
  test "002_S4_Valid_AND_Boolean_True" do
      scs = """
      int main() {
      \treturn 4 && -4;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 4 && -4; }"
  end
  
  test "003_S4_Valid_GE_Relational_False" do
      scs = """
      int main() {
      \treturn 11 >= 21;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 11 >= 21; }"
  end

  test "004_S4_Valid_GE_Relational_True" do
      scs = """
      int main() {
      \treturn 4 >= 13;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 4 >= 13; }"
  end

  test "005_S4_Valid_EQ_Relational_False" do
      scs = """
      int main() {
      \treturn 7 == 13;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 7 == 13; }"
  end

  test "006_S4_Valid_EQ_Relational_True" do
      scs = """
      int main() {
      \treturn 5 == 5;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 5 == 5; }"
  end

  test "007_S4_Valid_GT_Relation_False" do
      scs = """
      int main() {
      \treturn 3 > 9;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 3 > 9; }"
  end

  test "008_S4_Valid_GT_Relational_True" do
      scs = """
      int main() {
      \treturn 5 > 0;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 5 > 0; }"
  end

  test "009_S4_Valid_LE_Relational_False" do
      scs = """
      int main() {
      \treturn 7 <= 6;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 7 <= 6; }"
  end

  test "010_S4_Valid_LE_Relational_True" do
      scs = """
      int main() {
      \treturn 17 <= 17;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 17 <= 17; }"
  end

  test "011_S4_Valid_LT_Relational_False" do
      scs = """
      int main() {
      \treturn 5 < 1;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 5 < 1; }"
  end

  test "012_S4_Valid_LT_Relational_True" do
      scs = """
      int main() {
      \treturn 5 < 11;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 5 < 11; }"
  end

  test "013_S4_Valid_NE_Relational_False" do
      scs = """
      int main() {
      \treturn 4 != 4;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 4 != 4; }"
  end

  test "014_S4_Valid_NE_Relational_True" do
      scs = """
      int main() {
      \treturn 7 != 4;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 7 != 4; }"
  end

  test "015_S4_Valid_OR_Boolean_False" do
      scs = """
      int main() {
      \treturn 4 || 4;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 4 || 4; }"
  end

  test "016_S4_Valid_OR_Boolean_True" do
      scs = """
      int main() {
      \treturn 4 || 0;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 4 || 0; }"
  end

  test "017_S4_Valid_Precedence" do
      scs = """
      int main() {
      \treturn 1 && 7 || 0;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 1 && 7 || 0; }"
  end

  test "018_S4_Valid_Precedence" do
      scs = """
      int main() {
      \treturn 4 == 4 >= 1;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 4 == 4 >= 1; }"
  end

  test "019_S4_Valid_Precedence" do
      scs = """
      int main() {
      \treturn (4 || 1) && 4;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return (4 || 1) && 4; }"
  end

  test "020_S4_Valid_Precedence" do
      scs = """
      int main() {
      \treturn 1 && 4 || 1;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 1 && 4 || 1; }"
  end

  test "021_S4_Valid_Precedence" do
      scs = """
      int main() {
      \treturn (4 || 1) >= 2;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return (4 || 1) >= 2; }"
  end

  test "022_S4_Invalid_AND_First_Op_Missing" do
      scs = """
      int main() {
      \treturn 3 / ;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 3 / ; }"
  end

  test "023_S4_Invalid_OR_Second_Op_Missing" do
      scs = """
      int main() {
      \treturn 4 || ;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 4 || ; }"
  end

  test "024_S4_Invalid_Mid_Op_Missing" do
      scs = """
      int main() {
      \treturn 4 < < 9;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 4 < < 9; }"
  end

  test "025_S4_Invalid_Semicolon" do
      scs = """
      int main() {
      \treturn 1 <= 4
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return 1 <= 4 }"
  end
  
end