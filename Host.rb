require_relative 'NetworkInterfaceCard'
require_relative 'Module'

class Host < Module
  @networkInterfaceCards={}

  def initialize eventController
    super(eventController)
  end

  def newSimpleHost(eventController, speed)
    host=Host.new eventController
    host.newNetworkInterfaceCard(speed)
    return host
  end

  def newNetworkInterfaceCard(speed)
    nic=NetworkInterfaceCard.new(speed)
    @networkInterfaceCards['eth%d' % [@networkInterfaceCards.size]]=nic
  end
end