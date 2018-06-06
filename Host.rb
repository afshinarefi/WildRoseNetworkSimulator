require_relative 'NetworkInterfaceCard'
require_relative 'Module'

class Host < Module

  @services={}

  def initialize eventController
    super(eventController)
  end

  def newSimpleHost(eventController, speed)
    host=Host.new eventController
    host.addNetworkInterfaceCard(speed)
    return host
  end

  def getNIC number
    return @ios[number]
  end

  def addNetworkInterfaceCard(speed)
    ioNumber=addIO NetworkInterfaceCard.new speed, self
  end

  def process packet, ioNumber
    if ioNumber==nil
      @buffers[0].push packet
    else
      @services[packet[:service]].receive packet, self
    end
  end
end