require_relative 'Module'

class PipeModule < Module
  def initialize eventcontroller
    super(eventcontroller)
    addIO nil
    addIO nil
  end

  def connectX io
    @ios[0]=io
  end

  def getX
    @ios[0]
  end

  def connectY io
    @ios[1]=io
  end

  def getY
    @ios[1]
  end

  def process packet, ioNumber
    if ioNumber==0
      @buffers[1].push packet
    else
      @buffers[0].push packet
    end
    @eventController.newEvent self, @eventController.now
  end
end