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
    if ioNumber==0
      @eventController.log "%s%d | %s" % [self.class.name[0], @id, packet]
    end
    if packet.sections[:relay].has_key? getNetworkInterfaceCards[0].getMacAddress
      relays=packet.sections[:relay][getNetworkInterfaceCards[0].getMacAddress]
      packet.sections[:relay].delete(getNetworkInterfaceCards[0].getMacAddress)
      for dest in relays
        p=packet.copy
        p.sections[:destinationMAC]=dest
        @buffers[0].push p
      end
    end
    @eventController.newEvent self, @eventController.now
  end

  def getNetworkInterfaceCards
    @ios
  end

end