import ExUnit.CaptureLog

defmodule ExcTest do
    use Exunit.Case
    doctest ExC

    test "001_Valid_Return_0" do
        scs = File.read("../docs/testing_integration/Stage_1/001_S1_Valid_Return0.c")
        # target result file
        tar = File.read(""../docs/testing_integration/Stage_1/001_S1_Valid_Return0.s"")

        Assert exc.Start(scs)
end