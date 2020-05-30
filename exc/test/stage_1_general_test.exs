defmodule StageOneGeneral do 
    use ExUnit.Case
	
	
    test "001_S1_Valid_Return0" do 
    	"""
    	int main() {
    	return 0;
    	}
    	"""
    	|> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        
        assert exc_output == '0\n'
    end
end
