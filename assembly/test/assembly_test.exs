defmodule AssemblyTest do
  use ExUnit.Case
  doctest Assembly

  test "001S1ValidReturn0" do
    assert Assembly.start("../../docs/testingintegration/Stage 1/001S1Valid_Return0.c") == :ok
  end

test "002S1ValidReturn7" do
  	assert Assembly.start("../../docs/testingintegration/Stage 1/001S1ValidReturn7.c") == :ok
  end
  	
  test "003S1ValidReturnMD130"	do
  	assert Assembly.start("../../docs/testingintegration/Stage 1/003S1ValidReturnMD130.c") == :ok
  end
  	
  test "004S1ValidReturnBlank Spaces" do
  	assert Assembly.start("../../docs/testingintegration/Stage 1/004S1ValidReturnBlank Spaces.c") == :ok
  end
  	
  test "005S1ValidReturnNoLineB" do
  	assert Assembly.start("../../docs/testingintegration/Stage 1/005S1ValidReturnNoLineB.c") == :ok
  end
  	
  test "006S1ValidReturnSpace Chars" do
  	assert Assembly.start("../../docs/testingintegration/Stage 1/006S1ValidReturnSpace Chars.c") == :ok
  end
  
  test "007S1InvalidReturnNull" do
  	assert Assembly.start("../../docs/testingintegration/Stage 1/007S1InvalidReturnNull.c") == :error
  end
  
  test "008S1InvalidReturnNoFuncName" do
  	assert Assembly.start("../../docs/testingintegration/Stage 1/008S1InvalidReturnNoFuncName.c") == :error
  end
  
  test "009S1InvalidReturnNoParenth" do
  	assert Assembly.start("../../docs/testingintegration/Stage 1/009S1InvalidReturnNoParenth.c") == :error
  end
  
  test "010S1InvalidReturnNoBrack" do
  	assert Assembly.start("../../docs/testingintegration/Stage 1/010S1InvalidReturnNoBrack.c") == :error
  end
  
  test "011S1InvalidReturnNoSpaces" do
  	assert Assembly.start("../../docs/testingintegration/Stage 1/011S1InvalidReturnNoSpaces.c") == :error
  end
  
  test "012S1InvalidReturnComma" do
  	assert Assembly.start("../../docs/testingintegration/Stage 1/012S1InvalidReturnComma.c") == :error
  end
  
  test "013S1InvalidReturnCaps" do
  	assert Assembly.start("../../docs/testingintegration/Stage 1/013S1InvalidReturnCaps.c") == :error
  end
  
  test "014S1ValidReturnPrecZero" do
  	assert Assembly.start("../../docs/testingintegration/Stage 1/014S1Valid_ReturnPrecZero.c") == :ok
  end
  
end
