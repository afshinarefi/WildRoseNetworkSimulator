require_relative 'Host'
require_relative 'Switch'


class Network
  @hosts={}
  @switches={}

  def initialize

  end

  def newSimpleHost name, speed
    host=Host.newSimpleHost(speed)
    @hosts[name]=host
  end

  def newSwitch(name, size, speed)
    switch=Switch.new(size, speed)
    @switches[name]=switch
  end

  def newStar(hostCount, speed)
    network=Network.new
    for i in 0...hostCount
      network.newSimpleHost ("H%2d" % [i], speed)
    end
    network.newSwitch ('S00', hostCount, speed)
  end

end
