require_relative 'PipeModule'

class Link < PipeModule
  
  @length=0
  
  def initialize eventcontroller, length
    super(eventcontroller)
    @length=length
  end

  def bandwidth
    return [@ios[0].bandwidth,@ios[1].bandwidth].min
  end

  def delay
    return @length/300000000
  end

  def time packet
    return (packet[:dataSize]/bandwidth)+delay
  end
  
end