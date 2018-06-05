require_relative 'Host'
require_relative 'Switch'
require_relative 'EventController'


class Network
  @hosts={}
  @switches={}

  def initialize
    @eventController=EventController.new
  end

  def newSimpleHost name, speed
    host=Host.newSimpleHost(@eventController, speed)
    @hosts[name]=host
  end

  def newSwitch(name, size, speed)
    switch=Switch.new @eventController
    for i in 0...size
      switch.addPort "P%2d" % [i], speed
    end
    @switches[name]=switch
  end

  def self.newStar(hostCount, speed)
    network=Network.new
    for i in 0...hostCount
      network.newSimpleHost ("H%2d" % [i], speed)
    end
    network.newSwitch ('S00', hostCount, speed)
    for i in 0...@hosts.size
      host=@hosts[i]
      link=Link.new @eventController, 0
      link.connectCableX host.getNIC(0)
      @switches[0].addPort "P%2d" % [i], speed
      link.connectCableY @switches[0].getPort(i)
    end
  end

  def start
    @eventController.start
  end

end
