require_relative 'Module'

class DummyModule < Module
  def process packet, ioNumber
    print "Packet Received: "
    print packet
    puts
  end
end