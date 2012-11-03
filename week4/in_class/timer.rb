class Timer
  def Timer.time_code(&inBlock) #This is a class method
    startTime = Time.now
    inBlock.call
    endTime = Time.now
    (endTime - startTime)
  end
end
