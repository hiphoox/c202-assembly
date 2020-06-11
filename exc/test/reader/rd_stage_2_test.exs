defmodule StageTwoReader do
  use ExUnit.Case

  test "001_S2_Valid_Negative" do
      scs = """
      int main() {
      \treturn -7;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main() {  return -7; }"
  end
  
  test "002_S2_Valid_Bitwise" do
      scs = """
      int main(){
      return ~7;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main(){ return ~7; }"
  end
  
  test "003_S2_Valid_Bitwise_0" do
      scs = """
      int main(){
      return ~0;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main(){ return ~0; }"
  end
  
  test "004_S2_Valid_Not_7" do
      scs = """
      int main(){
      return !7;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main(){ return !7; }"
  end
  
  test "005_S2_Valid_Not_0" do
      scs = """
      int main(){
      return !0;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main(){ return !0; }"
  end
  
  test "006_S2_Valid_Multiple_Ops_1" do
      scs = """
      int main(){
      return -~7;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main(){ return -~7; }"
  end
  
  test "007_S2_Valid_Multiple_Ops_2" do
      scs = """
      int main(){
      return !-4;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main(){ return !-4; }"
  end
  
  test "008_S2_Valid_Multiple_Ops_3" do
      scs = """
      int main(){
      return !~0;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main(){ return !~0; }"
  end
  
  test "009_S2_Invalid_Wrong_Order_Negative" do
      scs = """
      int main(){
      return 7-;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main(){ return 7-; }"
  end
  
  test "010_S2_Invalid_Correct_Neg_Wrong_Bitwise_Order" do
      scs = """
      int main(){
      return -5~;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main(){ return -5~; }"
  end
  
  test "011_S2_Invalid_Bitwise_No_Semicolon" do
      scs = """
      int main(){
      return 0
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main(){ return 0 }"
  end
  
  test "012_S2_Invalid_Not_Missing_Const" do
      scs = """
      int main(){
      return !;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main(){ return !; }"
  end
  
  test "013_S2_Invalid_Not_Bitwise_Const" do
      scs = """
      int main(){
      return !~;
      }
      """
      assert Reader.clean_source_code_string(scs) == "int main(){ return !~; }"
  end
  
end