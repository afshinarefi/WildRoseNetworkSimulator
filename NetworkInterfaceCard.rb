require_relative 'Module'

class NetworkInterfaceCard < PipeModule

  def initialize eventcontroller, speed
    super(eventcontroller)
    connectPort Port.new eventcontroller, speed
  end

  def process packet, ioNumber
    if ioNumber==0
      packet.sections[:sourceMAC]=getMacAddress
      @buffers[1].push packet
    else
      if packet.sections[:destinationMAC]==getMacAddress
        @buffers[0].push packet
      end
    end
    @eventController.newEvent self, @eventController.now
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
    io.connectX self
  end

  def getPort
    getY
  end

  def connectCable io
    getPort.connectCable io
  end

end
