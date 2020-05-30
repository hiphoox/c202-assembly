defmodule StageTwoGeneral do 
    use ExUnit.Case
	
    test "001_S2_Valid_Negative" do 
    	"""
    	int main() {
    	return -7;
    	}
    	"""
    	|> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '249\n'
    end

    test "002_S2_Valid_Bitwise" do 
    	"""
    	int main() {
    	return ~7;
    	}
    	"""
    	|> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '248\n'
    end

    test "003_S2_Valid_Bitwise_0" do 
    	"""
    	int main() {
    	return ~0;
    	}
    	"""
    	|> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '255\n'
    end

    test "004_S2_Valid_Not_7" do 
    	"""
    	int main() {
    	return !7;
    	}
    	"""
    	|> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '248\n'
    end

    test "005_S2_Valid_Not_0" do 
    	"""
    	int main() {
    	return !0;
    	}
    	"""
    	|> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '255\n'
    end

    test "006_S2_Valid_Multiple_Ops_1" do 
    	"""
    	int main() {
    	return -~7;
    	}
    	"""
    	|> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '8\n'
    end

    test "008_S2_Valid_Multiple_Ops_3" do 
    	"""
    	int main() {
    	return !~0;
    	}
    	"""
    	|> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '0\n'
    end

end