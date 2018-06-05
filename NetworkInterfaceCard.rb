require_relative 'Module'

class NetworkInterfaceCard < PipeModule

  @macAddress=""

  def initialize eventcontroller, speed
    super(eventcontroller)
    connectPort Port.new eventcontroller, speed, self
  end

  def process packet, ioNumber
    if ioNumber==0
      packet[:sourceMAC]=getMacAddress
      buffers[1].push packet
    else
      buffers[0].push packet
    end
  end

  def getMacAddress
    getPort.getMacAddress
  end

  def connectSlot io
    connectX io
  end
  
  def getSlot
    getX
  end

  def connectPort io
    connectY io
  end

  def getPort
    getY
  end


end