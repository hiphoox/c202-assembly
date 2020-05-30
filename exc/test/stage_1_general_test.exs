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

    test "002_S1_Valid_Return7" do 
    	"""
    	int main() {
    	return 7;
    	}
    	"""
    	|> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '7\n'
    end

    test "002_S1_Valid_ReturnMD130" do 
        """
        int main() {
        return 130;
        }
        """
        |> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '130\n'
    end

    test "004_S1_Valid_ReturnBlankSpaces" do 
    	"""
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
    	|> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '1\n'
    end

    test "005_S1_Valid_ReturnNoLineB" do 
    	"""
    	int main(){return 1;}
    	"""
    	|> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '1\n'
    end

    test "006_S1_Valid_ReturnSpaceChars" do 
        """
        int main    ()  {



        return       1       ;
        }
        """
        |> Helpers.GeneralTester.start_general_test_compilation
        exc_output = Invoker.invoke_test_output()
        assert exc_output == '1\n'
    end

    # test "007_S1_Invalid_ReturnNull" do 
    #     """
    #     int main() {
    #      return;
    #     }
    #     """
    #     |> Helpers.GeneralTester.start_general_test_compilation
    #     exc_output = Invoker.invoke_test_output()
    #     assert exc_output == 'error message'
    # end

    # test "008_S1_Invalid_ReturnNoFuncName" do 
    #     """
    #     int () {
    #         return 1;
    #     }
    #     """
    #     |> Helpers.GeneralTester.start_general_test_compilation
    #     exc_output = Invoker.invoke_test_output()
    #     assert exc_output == 'error message'
    # end

    # test "009_S1_Invalid_ReturnNoParenth" do 
    #     """
    #     int main) {
    #         return 1;
    #     }   
    #     """
    #     |> Helpers.GeneralTester.start_general_test_compilation
    #     exc_output = Invoker.invoke_test_output()
    #     assert exc_output == 'error message'
    # end

    # test "010_S1_Invalid_ReturnNoBrack" do 
    #     """
    #     int main() 
    #         return 13;
    #     }   
    #     """
    #     |> Helpers.GeneralTester.start_general_test_compilation
    #     exc_output = Invoker.invoke_test_output()
    #     assert exc_output == 'error message'
    # end

    # test "011_S1_Invalid_ReturnNoSpaces" do
    #     """
    #     intmain() {
    #         return 44;
    #     }   
    #     """
    #     |> Helpers.GeneralTester.start_general_test_compilation
    #     exc_output = Invoker.invoke_test_output()
    #     assert exc_output == 'error message'
    # end

    # test "012_S1_Invalid_ReturnComma" do
    #     """
    #     int main() {
    #         return 25,
    #     }  
    #     """
    #     |> Helpers.GeneralTester.start_general_test_compilation
    #     exc_output = Invoker.invoke_test_output()
    #     assert exc_output == 'error message'
    # end

    # test "013_S1_Invalid_ReturnCaps" do
    #     """
    #     Int main() {
    #         Return 1;
    #     }  
    #     """
    #     |> Helpers.GeneralTester.start_general_test_compilation
    #     exc_output = Invoker.invoke_test_output()
    #     assert exc_output == 'error message'
    # end

    # test "014_S1_Invalid_ReturnPrecZero" do
    #     """
    #     int main() {
    #         return 007;
    #     }   
    #     """
    #     |> Helpers.GeneralTester.start_general_test_compilation
    #     exc_output = Invoker.invoke_test_output()
    #     assert exc_output == 'error message'
    # end
end
