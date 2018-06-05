require_relative 'Module'

class Link < Module
  
  
  @length=0
  
  def initialize eventcontroller ,portA, portB, length
    super(eventcontroller)
    addIO portA
    addIO portB
    @length=length
  end

  def bandwidth
    return [@ios[0].bandwidth,ios[1].bandwidth].min
  end

  def delay
    return @length/300000000
  end

  def time packet
    return (packet.size/bandwidth)+delay
  end

  def receive packet,from
    for i in 0...ios.size
      if from == ios[i]
        process packet, i
      end
    end
  end

  def process packet, ioNumber
    if ioNumber==0
      buffers[1].push packet
    else
      buffers[0].push packet
    end
  end

  
end
