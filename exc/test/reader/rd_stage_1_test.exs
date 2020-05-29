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
  
  test "005_S1_Valid_ReturnNoLineB" do
      scs = """
      int main(){return 1;}
      """
      assert Reader._generate_source_code_string(scs) == "int main(){return 1;}"
  end
  
  test "006_S1_Valid_ReturnSpaceChars" do
      scs = """
      int	main    () 	{



      return       1 	 	 ;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main    ()  {    return       1     ; }" 
  end
  
  test "007_S1_Invalid_ReturnNull" do
      scs = """
      int main() {
      return;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() { return; }"
  end
  
  test "008_S1_Invalid_ReturnNoFuncName" do
      scs = """
      int () {
      return 1;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int () { return 1; }"
  end
  
  test "009_S1_Invalid_ReturnNoParenth" do
      scs = """
      int main) {
      return 1;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main) { return 1; }"
  end
  
  test "010_S1_Invalid_ReturnNoBrack" do
      scs = """
      int main() 
      return 13;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main()  return 13; }"
  end
  
  test "011_S1_Invalid_ReturnNoSpaces" do
      scs = """
      intmain() {
      return 44;
      }
      """
      assert Reader._generate_source_code_string(scs) == "intmain() { return 44; }"
  end

	test "012_S1_Invalid_ReturnComma" do
      scs = """
      int main() {
      return 25,
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() { return 25, }"
  end
  
  test "013_S1_Invalid_ReturnCaps" do
      scs = """
      Int main() {
      Return 1;
      }
      """
      assert Reader._generate_source_code_string(scs) == "Int main() { Return 1; }"
  end
  
  test "014_S1_Valid_ReturnPrecZero" do
      scs = """
      int main() {
      return 007;
      }
      """
      assert Reader._generate_source_code_string(scs) == "int main() { return 007; }"
  end
  
end