class Worker
  def Worker.work(&inBlock)
    x = inBlock.call
  end

  def Worker.work(count = 1, &inBlock)
    result = nil
    count.times do
      result = inBlock.call
    end
    result
  end
end
