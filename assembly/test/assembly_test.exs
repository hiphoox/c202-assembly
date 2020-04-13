defmodule AssemblyTest do
  use ExUnit.Case
  doctest ExC

  test "001S1ValidReturn0" do
    assert ExC.start_compilation("../docs/testing_integration/Stage_1/001_S1_Valid_Return0.c") == :ok
  end

  test "002S1ValidReturn7" do
  	assert ExC.start_compilation("../docs/testing_integration/Stage_1/002_S1_Valid_Return7.c") == :ok
  end
  	
  test "003S1ValidReturnMD130"	do
  	assert ExC.start_compilation("../docs/testing_integration/Stage_1/003_S1_Valid_ReturnMD130.c") == :ok
  end
  	
  test "004S1ValidReturnBlank Spaces" do
  	assert ExC.start_compilation("../docs/testing_integration/Stage_1/004_S1_Valid_ReturnBlankSpaces.c") == :ok
  end
  	
  test "005S1ValidReturnNoLineB" do
  	assert ExC.start_compilation("../docs/testing_integration/Stage_1/005_S1_Valid_ReturnNoLineB.c") == :ok
  end
  	
  test "006S1ValidReturnSpaceChars" do
  	assert ExC.start_compilation("../docs/testing_integration/Stage_1/006_S1_Valid_ReturnSpaceChars.c") == :ok
  end
  
  test "007S1InvalidReturnNull" do
  	assert ExC.start_compilation("../docs/testing_integration/Stage_1/007_S1_Invalid_ReturnNull.c") == :error
  end
  
  test "008S1InvalidReturnNoFuncName" do
  	assert ExC.start_compilation("../docs/testing_integration/Stage_1/008_S1_Invalid_ReturnNoFuncName.c") == :error
  end
  
  test "009S1InvalidReturnNoParenth" do
  	assert ExC.start_compilation("../docs/testing_integration/Stage_1/009_S1_Invalid_ReturnNoParenth.c") == :error
  end
  
  test "010S1InvalidReturnNoBrack" do
  	assert ExC.start_compilation("../docs/testing_integration/Stage_1/010_S1_Invalid_ReturnNoBrack.c") == :error
  end
  
  test "011S1InvalidReturnNoSpaces" do
  	assert ExC.start_compilation("../docs/testing_integration/Stage_1/011_S1_Invalid_ReturnNoSpaces.c") == :error
  end
  
  test "012S1InvalidReturnComma" do
  	assert ExC.start_compilation("../docs/testing_integration/Stage_1/012_S1_Invalid_ReturnComma.c") == :error
  end
  
  test "013S1InvalidReturnCaps" do
  	assert ExC.start_compilation("../docs/testing_integration/Stage_1/013_S1_Invalid_ReturnCaps.c") == :error
  end
  
  test "014S1ValidReturnPrecZero" do
  	assert ExC.start_compilation("../docs/testing_integration/Stage_1/014_S1_Valid_ReturnPrecZero.c") == :ok
  end
  
end
