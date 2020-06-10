defmodule StageTwoGeneral do 
    use ExUnit.Case
	
    test "001_S2_Valid_Negative" do 
    	"""
    	int main() {
    	return -7;
    	}
    	"""
    	|> GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '249\n'
    end

    test "002_S2_Valid_Bitwise" do 
    	"""
    	int main() {
    	return ~7;
    	}
    	"""
    	|> GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '248\n'
    end

    test "003_S2_Valid_Bitwise_0" do 
    	"""
    	int main() {
    	return ~0;
    	}
    	"""
    	|> GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '255\n'
    end

    test "004_S2_Valid_Not_7" do 
    	"""
    	int main() {
    	return !7;
    	}
    	"""
    	|> GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '0\n'
    end

    test "005_S2_Valid_Not_0" do 
    	"""
    	int main() {
    	return !0;
    	}
    	"""
    	|> GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '1\n'
    end

    test "006_S2_Valid_Multiple_Ops_1" do 
    	"""
    	int main() {
    	return -~7;
    	}
    	"""
    	|> GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '8\n'
    end

    test "008_S2_Valid_Multiple_Ops_3" do 
    	"""
    	int main() {
    	return !~0;
    	}
    	"""
    	|> GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '0\n'
    end

	test "009_S2_Invalid_Wrong_Order_Negative" do 
    	msg = """
        int main(){
        return 7-;
        }
        """
    	|> GeneralTester.start_general_test_compilation
        assert msg == Common.StringElements.parser_error_missing_token()
    end

	test "010_S2_Invalid_Correct_Neg_Wrong_Bitwise_Order" do 
    	msg = """
        int main(){
        return -5~;
        }
        """
    	|> GeneralTester.start_general_test_compilation
        assert msg == Common.StringElements.parser_error_missing_token()
    end

	test "011_S2_Invalid_Bitwise_No_Semicolon" do 
    	msg = """
        int main(){
        return 0
        }
        """
    	|> GeneralTester.start_general_test_compilation
        assert msg == Common.StringElements.parser_error_missing_token()
    end

	test "012_S2_Invalid_Not_Missing_Const" do 
    	msg = """
        int main(){
        return !;
        }
        """
    	|> GeneralTester.start_general_test_compilation
        assert msg == Common.StringElements.parser_error_missing_token()
    end

	test "013_S2_Invalid_Not_Bitwise_Const" do 
    	msg = """
        int main(){
        return !~;
        }
        """
    	|> GeneralTester.start_general_test_compilation
        assert msg == Common.StringElements.parser_error_missing_token()
    end

end