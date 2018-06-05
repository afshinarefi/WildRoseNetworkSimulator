require_relative 'NetworkInterfaceCard'

class Host
  @nIC={}

  def initialize
  end

  def newSimpleHost(speed)
    host=Host.new
    host.newNIC(speed)
    return host
  end

  def newNIC(speed)
    @nIC['eth%d' % [@nIC.size]]=NetworkInterfaceCard.new(speed)
  end
end