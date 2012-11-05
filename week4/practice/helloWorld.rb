class HelloWorld

  # A simple function to write a single string to a single output file. We use
  # the block syntax for file operations, since that implicitly handles the file
  # close operation. There's also no checking here to make sure the output file
  # is valid (since it's hard-coded here). We use append mode so that any
  # previous contents aren't lost.
  def simpleWrite
    outFileName = "my_output.txt"
    outString = "Hello World!"

    File.open(outFileName, "a") do |outFile|
      outFile.puts outString
    end
  end

end
