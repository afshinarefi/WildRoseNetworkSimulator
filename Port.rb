require_relative 'PipeModule'

class Port < PipeModule

  @@macFactory=MAC.new
  @macAddress=nil
  @bandwidth=0
  @owner=nil
  
  def initialize eventcontroller , bandwidth, owner
    super(eventcontroller)
    @bandwidth=bandwidth
    @owner=owner
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

end
