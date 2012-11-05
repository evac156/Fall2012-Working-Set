class IOPractice
  @@FILENAME_PATTERN = /^[A-Za-z0-9_]{1,25}(\.[a-z0-9]{1,3})?$/

  # Check to see if a given String is a valid file name, using a regular
  # expression.
  def isValidFileName?(fname)
    status = (fname.is_a? String) && (!(fname =~ @@FILENAME_PATTERN).nil?)
  end
  
  # Check to see if the parameter given is the name of a valid, existing file.
  def isValidFile?(fname)
    status = false;

    if (isValidFileName?(fname))
      puts("Received valid file name \"#{fname}\"");
      if (File.exist? fname)
        puts("File \"#{fname}\" exists. Proceeding.");
        status = true
      else
        puts("File \"#{fname}\" does not exist. Doing nothing.");
      end
    else
      puts("Parameter #{fname.to_s} is not a valid file name. Doing nothing.")
    end
    status
  end

  # Takes the name of a file, makes sure it's valid, opens it for reading, and
  # echoes each line of the file, with the line number prefixed.
  def echoFile1(fname)
    if (isValidFile?(fname))
      thisFile = File.open(fname, "r")
      puts
      lineNum = 0
      while line = thisFile.gets
        puts("#{lineNum}: #{line}")
        lineNum += 1
      end #while
      thisFile.close
    end # if
  end # method

  # Using the File.open block syntax, as per p.148 of the book. In this case,
  # we don't have to explicitly close, or have any exception handling.
  def echoFile2(fname)
    if (isValidFile?(fname))
      File.open(fname, "r") do |thisFile|
        puts
        lineNum = 0
        while line = thisFile.gets
          puts("#{lineNum}: #{line}")
          lineNum += 1
        end # while
      end # do-block
    end # if
  end # method

  # Variant of echoFile2, above, still using block syntax, but creating the
  # Proc object first. This doesn't work. Why? It says that there is no local
  # variable or method 'file'. Now, it seems to me that the block syntax for
  # File.open *should* create the local parameter here, just as it did in the
  # first two versions, and then pass that parameter to the block. But it
  # doesn't work that way.
  def echoFile3(fname)
    if (isValidFile?(fname))
      dumpProc = Proc.new do |thisFile|
        puts
        lineNum = 0
        while line = thisFile.gets
          puts("#{lineNum}: #{line}")
          lineNum += 1
        end # while
      end # do-block of Proc object
      File.open(fname, "r") |file| dumpProc
    end # if
  end # method

  # Create a proc object that echoes an open file line by line
  def makeDumpProc
    dumper = Proc.new do |thisFile|
      puts
      lineNum = 0
      while line = thisFile.gets
        puts("#{lineNum}: #{line}")
        lineNum += 1
      end # while
    end # do-block
    dumper
  end

  # This is like version 3, above, but it creates the Proc object in a separate
  # method. It fails for the same reason, saying there's no local variable
  # 'thisFile'. Again, Ruby weirdness. Should create the local variable and
  # pass it to the invocation of the Proc object
  def echoFile4(fname)
    if (isValidFile?(fname))
      dumpProc = makeDumpProc
      puts("dumpProc = #{dumpProc.inspect}")
      File.open(fname, "r") |thisFile| dumpProc
    end # if
  end

  # This one makes it work again, if we explicitly create the local variable
  # first and then pass it as a parameter to the Proc.call. That should be done
  # just as well byt the other form, but Ruby is just weird. This doesn't get us
  # the advantages of the block form, though.
  def echoFile5(fname)
    if (isValidFile?(fname))
      dumpProc = makeDumpProc
      puts("dumpProc = #{dumpProc.inspect}")
      thisFile = File.open(fname, "r")
      dumpProc.call thisFile
    end # if
  end

  # So if we want both, the block form of File.open, and a pre-created Proc
  # object, we do this. Use the block syntax of File.open, which creates the
  # local variable, then invoke our proc on that.
  def echoFile6(fname)
    if (isValidFile?(fname))
      dumpProc = makeDumpProc
      puts("dumpProc = #{dumpProc.inspect}")
      thisFile = File.open(fname, "r") do |thisFile|
        dumpProc.call thisFile
      end # do-block
    end # if
  end

  # Now that we've figured out reading from a file and echoing to the console,
  # try echoing to another file. This is going to check to see if the inbound
  # file is valid (and exists), and echo it to the target. If the target already
  # exists, we'll append to it. If it doesn't, we'll create a new one and write
  # to it.
  def echoFile7(inFname, outFname)
    validParms = true
    if (!isValidFile?(inFname))
      puts("#{inFname.to_s} is not a valid input file.")
      validParms = false
    end
    if (!isValidFileName?(outFname))
      puts("#{outFname.to_s} is not a valid output file name.")
      validParms = false
    end
    if (validParms)
      if (inFname == outFname)
        puts("Input #{inFname} and output #{outFname} are the same file.")
        validParms = false
      end
    end
    if (validParms)
      begin
        outFile = File.open(outFname, "a")
        File.open(inFname, "r") do |inFile|
          lineNum = 0
          while line = inFile.gets
            outFile.puts("#{lineNum}: #{line}")
            lineNum += 1
          end # while
        end # do-block
      ensure
        if (outFile.is_a? File)
          outFile.close
        end # if
      end # ensure
    end # if
  end # method

  # Trying a simple echo method that does byte-by-byte. Open the input file,
  # iterate over the bytes, add each byte (as an integer and character) to the
  # current line of output, and when we hit a line feed, spit out the 
  def echoFile8(fname)
    if (isValidFile?(fname))
      File.open(fname, "r") do |thisFile|
        puts
        lineNum = 0
        lineOut = ""
        thisFile.each_byte do |ch|
          if (ch != 10)
            if (lineOut.length == 0)
              lineOut = "#{lineNum}: "
            else
              lineOut += " "
            end # else
            lineOut += "#{ch.chr}:#{ch}"
          else # (ch == 10)
            puts lineOut
            lineOut = ""
            lineNum += 1
          end # else
        end # ch do-block
      end # thisFile do-block
    end # if
    nil
  end # method

  # And try one with the each_line method, letting the user pass a string as the
  # line separator. If there's no separator given, default to $/, which seems
  # to be the normal system line separator, and is what is used by the each_line
  # method.
  def echoFile9(fname, lineSep=$/)
    if (isValidFile?(fname))
      File.open(fname, "r") do |thisFile|
        puts
        thisFile.each_line(lineSep).with_index do |thisLine, lineNum|
          puts ("#{lineNum}: #{thisLine}")
        end # thisLine do-block
      end # thisFile do-block
    end # if
    nil
  end # method

  # According to the online RDoc, each, each_line, and lines are all synonyms.
  # According to the printed RDoc in the book, lines does something different.
  # So let's try this to see if there really is any difference. There isn't.
  def echoFile10(fname, lineSep=$/)
    if (isValidFile?(fname))
      File.open(fname, "r") do |thisFile|
        puts
        thisFile.lines(lineSep).with_index do |thisLine, lineNum|
          puts ("#{lineNum}: #{thisLine}")
        end # thisLine do-block
      end # thisFile do-block
    end # if
    nil
  end # method
end
