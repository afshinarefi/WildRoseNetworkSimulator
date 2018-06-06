require_relative 'Module'

class DummyModule < Module
  def process packet, ioNumber
    print "Packet Received at #{@eventController.now}: "
    print packet
    puts
  end
end