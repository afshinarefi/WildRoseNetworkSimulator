require_relative 'PipeModule'

class DummyModule < PipeModule

  def initialize eventController, name
    super(eventController)
    @name=name
  end

  def process packet, ioNumber
    print "Packet Received at #{@eventController.now} by #{@name}: "
    print packet
    puts
  end
end