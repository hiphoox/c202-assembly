defmodule StageThreeGeneral do 
    use ExUnit.Case
	
    test "001_S1_Valid_Add" do 
    	"""
    	int main(){
            return 4 + 7;
        }
    	"""
    	|> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '11\n'
    end

    test "002_S1_Valid_SubstractPositive" do 
        """
        int main(){
            return 4 - 17;
        }       
        """
        |> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '243\n'
    end

    test "003_S1_Valid_SubstractNegative" do 
        """
        int main(){
            return -7 - -8;
        }       
        """
        |> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '1\n'
    end

    test "004_S1_Valid_DivPositive" do 
        """
        int main(){
            return 18 / 3;
        }
        """
        |> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '6\n'
    end

    test "005_S1_Valid_DivNegative" do 
        """
        int main(){
            return -8 / -4;
        }
        """
        |> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '2\n'
    end

    test "006_S1_Valid_MulPositive" do 
        """
        int main(){
            return 11 * 17;
        }
        """
        |> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '187\n'
    end

    test "007_S1_Valid_MultNeg" do 
        """
        int main(){
            return 5 * -13;
        }
        """
        |> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '191\n'
    end

    test "008_S1_Valid_Parenthesis" do 
        """
        int main(){
            return 7 * (5 * (8 - 5));
        }
        """
        |> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '105\n'
    end

    test "009_S1_Valid_SimpleParenthesis" do 
        """
        int main(){
            return 2 * (5 + 3);
        }
        """
        |> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '16\n'
    end

    test "010_S1_Valid_Precedence" do 
        """
        int main(){
            return 2 * 5 + 21 / 9;
        }
        """
        |> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '12\n'
    end

    test "011_S1_Valid_Bitwise_NoParenthesis" do 
        """
        int main(){
            return ~7 - 4;
        }
        """
        |> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '244\n'
    end

    test "012_S1_Valid_Bitwise_Parenthesis" do 
        """
        int main(){
            return ~(7 + 4);
        }
        """
        |> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '244\n'
    end

    test "013_S1_Valid_Multiple_Parenthesis" do 
        """
        int main(){
            return ~((7 + 4) / (8 * (5 - 3)));
        }
        """
        |> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '255\n'
    end
    
end
