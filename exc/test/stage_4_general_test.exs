# defmodule StageFourGeneral do
#   use ExUnit.Case

#   test "001_S4_Valid_AND_Boolean_False" do
#     """
#     int main(){
#         return 7 && 4;
#       }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '1\n'
#   end

#   test "002_S4_Valid_AND_Boolean_True" do
#     """
#     int main(){
# 	    return 4 && -4;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '1\n'
#   end

#   test "003_S4_Valid_GE_Relational_False" do
#     """
#     int main(){
# 	    return 11 >= 21;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '0\n'
#   end

#   test "004_S4_Valid_GE_Relational_True" do
#     """
#     int main(){
# 	    return 4 >= 3;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '1\n'
#   end

#   test "005_S4_Valid_EQ_Relational_False" do
#     """
#     int main(){
# 	    return 7 == 13;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '0\n'
#   end

#   test "006_S4_Valid_EQ_Relational_True" do
#     """
#     int main(){
# 	    return 5 == 5;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '1\n'
#   end

#   test "007_S4_Valid_GT_Relation_False" do
#     """
#     int main(){
# 	    return 3 > 9;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '0\n'
#   end

#   test "008_S4_Valid_GT_Relational_True" do
#     """
#     int main(){
# 	    return 5 > 0;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '1\n'
#   end

#   test "009_S4_Valid_LE_Relational_False" do
#     """
#     int main(){
# 	    return 7 <= 6;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '0\n'
#   end

#   test "010_S4_Valid_LE_Relational_True" do
#     """
#     int main(){
# 	    return 17 <= 17;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '1\n'
#   end

#   test "011_S4_Valid_LT_Relational_False" do
#     """
#     int main(){
# 	    return 5 < 1;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '0\n'
#   end

#   test "012_S4_Valid_LT_Relational_True" do
#     """
#     int main(){
# 	    return 5 < 11;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '1\n'
#   end

#   test "013_S4_Valid_NE_Relational_False" do
#     """
#     int main(){
# 	    return 4 != 4;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '0\n'
#   end

#   test "014_S4_Valid_NE_Relational_True" do
#     """
#     int main(){
# 	    return 7 != 4;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '1\n'
#   end

#   test "015_S4_Valid_OR_Boolean_False" do
#     """
#     int main(){
# 	    return 4 || 4;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '1\n'
#   end

#   test "016_S4_Valid_OR_Boolean_True" do
#     """
#     int main(){
# 	    return 4 || 0;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '1\n'
#   end

#   test "017_S4_Valid_Precedence" do
#     """
#     int main(){
# 	    return 1 && 7 || 0;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '1\n'
#   end

#   test "018_S4_Valid_Precedence" do
#     """
#     int main(){
# 	    return 4 == 4 >= 1;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '0\n'
#   end

#   test "019_S4_Valid_Precedence" do
#     """
#     int main(){
# 	    return (4 || 1) && 4;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '1\n'
#   end

#   test "020_S4_Valid_Precedence" do
#     """
#     int main(){
# 	    return 1 && 4 || 1;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '1\n'
#   end

#   test "021_S4_Valid_Precedence" do
#     """
#     int main(){
# 	    return (4 || 1) >= 2;
#     }
#     """
#     |> GeneralTester.start_general_test_compilation
#       exc_output = Invoker.invoke_test_output()
#       assert exc_output == '0\n'
#   end

#   # test "022_S4_Invalid_AND_First_Op_Missing" do
#   #   """
#   #   int main(){
# 	#   return && 4;
#   #   }
#   #   """
#   #   |> GeneralTester.start_general_test_compilation
#   #     exc_output = Invoker.invoke_test_output()
#   #     assert exc_output == '0\n'
#   # end

#   # test "023_S4_Invalid_OR_Second_Op_Missing" do
#   #   """
#   #   int main(){
# 	#   return 4 || ;
#   #   }
#   #   """
#   #   |> GeneralTester.start_general_test_compilation
#   #     exc_output = Invoker.invoke_test_output()
#   #     assert exc_output == '0\n'
#   # end

#   # test "024_S4_Invalid_Mid_Op_Missing" do
#   #   """
#   #   int main(){
# 	#   return 4 < < 9;
#   #   }
#   #   """
#   #   |> GeneralTester.start_general_test_compilation
#   #     exc_output = Invoker.invoke_test_output()
#   #     assert exc_output == '0\n'
#   # end

#   # test "025_S4_Invalid_Semicolon" do
#   #   """
#   #   int main(){
# 	#   return 1 <= 4
#   #   }
#   #   """
#   #   |> GeneralTester.start_general_test_compilation
#   #     exc_output = Invoker.invoke_test_output()
#   #     assert exc_output == '0\n'
#   # end
  
# end
