require_relative 'NetworkInterfaceCard'
require_relative 'Module'

class Host < Module

  @services={}

  def initialize eventController
    super(eventController)
  end

  def self.newSimpleHost(eventController, speed)
    host=Host.new eventController
    host.addNetworkInterfaceCard(speed)
    return host
  end

  def getNIC number
    return @ios[number]
  end

  def addNetworkInterfaceCard(speed)
    nic=NetworkInterfaceCard.new @eventController, speed
    ioNumber=addIO nic
    nic.connectSlot self
  end

  def process packet, ioNumber
    if packet.sections[:relay].has_key? getNetworkInterfaceCards[0].getMacAddress
      for dest in packet.sections[:relay][getNetworkInterfaceCards[0].getMacAddress]
        packet.sections[:destinationMAC]=dest
        @buffers[0].push packet
      end
    end
    @eventController.newEvent self, @eventController.now
  end

  def getNetworkInterfaceCards
    @ios
  end

end