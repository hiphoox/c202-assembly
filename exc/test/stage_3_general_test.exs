defmodule StageThreeGeneral do
    use ExUnit.Case
	
    test "001_S3_Valid_Add" do 
    	"""
    	int main(){
            return 4 + 7;
        }
    	"""
    	|> GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '11\n'
    end

    test "002_S3_Valid_SubstractPositive" do 
        """
        int main(){
            return 4 - 17;
        }       
        """
        |> GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '243\n'
    end

    test "003_S3_Valid_SubstractNegative" do 
        """
        int main(){
            return -7 - -8;
        }       
        """
        |> GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '1\n'
    end

    test "004_S3_Valid_DivPositive" do 
        """
        int main(){
            return 18 / 3;
        }
        """
        |> GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '6\n'
    end

    test "005_S3_Valid_DivNegative" do 
        """
        int main(){
            return -8 / -4;
        }
        """
        |> GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '2\n'
    end

    test "006_S3_Valid_MulPositive" do 
        """
        int main(){
            return 11 * 17;
        }
        """
        |> GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '187\n'
    end

    test "007_S3_Valid_MultNeg" do 
        """
        int main(){
            return 5 * -13;
        }
        """
        |> GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '191\n'
    end

    test "008_S3_Valid_SimpleParenthesis" do 
        """
        int main(){
            return 2 * (5 + 3);
        }
        """
        |> GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '16\n'
    end

    test "009_S3_Valid_Precedence" do 
        """
        int main(){
            return 2 * 5 + 21 / 9;
        }
        """
        |> GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '12\n'
    end

    test "010_S3_Valid_Bitwise_NoParenthesis" do 
        """
        int main(){
            return ~7 - 4;
        }
        """
        |> GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '244\n'
    end

    test "011_S3_Valid_Bitwise_Parenthesis" do 
        """
        int main(){
            return ~(7 + 4);
        }
        """
        |> GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '244\n'
    end

    test "012_S3_Invalid_Div_Missing_Operator" do 
    	msg = """
        int main(){
        return 3 / ;
        }
        """
    	|> GeneralTester.start_general_test_compilation
        assert msg == "error in parser: token missing error"
    end

    test "013_S3_Invalid_Sum_Missing_Operator" do 
    	msg = """
        int main(){
        return 7 + ;
        }
        """
    	|> GeneralTester.start_general_test_compilation
        assert msg == "error in parser: token missing error"
    end

    test "014_S3_Invalid_Parenthesis_Middle_Operator" do 
    	msg = """
        int main(){
	    return (6 + 4) 10;
        }
    	"""
    	|> GeneralTester.start_general_test_compilation
        assert msg == "error in parser: token missing error"
    end

    test "015_S3_Invalid_Neg_Missing_Operator" do 
    	msg = """
        int main(){
	    return (6 + 4) -;
        }
    	"""
    	|> GeneralTester.start_general_test_compilation
        assert msg == "error in parser: token missing error"
    end
    
end
