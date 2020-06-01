defmodule StageFourGeneral do
  use ExUnit.Case

  test "001_S1_Valid_And" do 
    """
    int main(){
          return 4 && 7;
      }
    """
    |> GeneralTester.start_general_test_compilation
      exc_output = Invoker.invoke_test_output()
      assert exc_output == '1\n'
  end
  
end
