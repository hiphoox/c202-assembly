defmodule AssemblyTest do
  use ExUnit.Case
  doctest Assembly
  
  test "001_S1_Valid_Return0" do
  	assert assembly.main("../../docs/testing_integration/Stage 1/001_S1_Valid_Return0.c") == :ok
  end

  test "002_S1_Valid_Return7" do
  	assert assembly.main("../../docs/testing_integration/Stage 1/001_S1_Valid_Return7.c") == :ok
  end
  	
  test "003_S1_Valid_ReturnMD130"	do
  	assert assembly.main("../../docs/testing_integration/Stage 1/003_S1_Valid_ReturnMD130.c") == :ok
  end
  	
  test "004_S1_Valid_ReturnBlank Spaces" do
  	assert assembly.main("../../docs/testing_integration/Stage 1/004_S1_Valid_ReturnBlank Spaces.c") == :ok
  end
  	
  test "005_S1_Valid_ReturnNoLineB" do
  	assert assembly.main("../../docs/testing_integration/Stage 1/005_S1_Valid_ReturnNoLineB.c") == :ok
  end
  	
  test "006_S1_Valid_ReturnSpace Chars" do
  	assert assembly.main("../../docs/testing_integration/Stage 1/006_S1_Valid_ReturnSpace Chars.c") == :ok
  end
  
  test "007_S1_Invalid_ReturnNull" do
  	assert assembly.main("../../docs/testing_integration/Stage 1/007_S1_Invalid_ReturnNull.c") == :error
  end
  
  test "008_S1_Invalid_ReturnNoFuncName" do
  	assert assembly.main("../../docs/testing_integration/Stage 1/008_S1_Invalid_ReturnNoFuncName.c") == :error
  end
  
  test "009_S1_Invalid_ReturnNoParenth" do
  	assert assembly.main("../../docs/testing_integration/Stage 1/009_S1_Invalid_ReturnNoParenth.c") == :error
  end
  
  test "010_S1_Invalid_ReturnNoBrack" do
  	assert assembly.main("../../docs/testing_integration/Stage 1/010_S1_Invalid_ReturnNoBrack.c") == :error
  end
  
  test "011_S1_Invalid_ReturnNoSpaces" do
  	assert assembly.main("../../docs/testing_integration/Stage 1/011_S1_Invalid_ReturnNoSpaces.c") == :error
  end
  
  test "012_S1_Invalid_ReturnComma" do
  	assert assembly.main("../../docs/testing_integration/Stage 1/012_S1_Invalid_ReturnComma.c") == :error
  end
  
  test "013_S1_Invalid_ReturnCaps" do
  	assert assembly.main("../../docs/testing_integration/Stage 1/013_S1_Invalid_ReturnCaps.c") == :error
  end
  
  test "014_S1_Valid_ReturnPrecZero" do
  	assert assembly.main("../../docs/testing_integration/Stage 1/014_S1_Valid_ReturnPrecZero.c") == :ok
  end
  
end
