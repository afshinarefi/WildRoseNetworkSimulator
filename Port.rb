require_relative 'PipeModule'
require_relative 'MAC'

class Port < PipeModule

  @@macFactory=MAC.new
  @macAddress=nil
  @bandwidth=0
  
  def initialize eventcontroller , bandwidth
    super(eventcontroller)
    @bandwidth=bandwidth
    @macAddress=@@macFactory.getAddress
  end

  def getMacAddress
    @macAddress
  end

  def bandwidth
    @bandwidth
  end

  def connectStatic io
    connectX io
  end

  def connectDynamic io
    connectY io
  end

  def connectCable io
    connectDynamic io
  end

end
