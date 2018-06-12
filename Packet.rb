class Packet

  attr_reader :sections
  attr_writer :sections

  @@nextID=0

  def initialize dataSize
    @sections={dataSize:dataSize}
    @id=@@nextID
    @@nextID+=1
  end

  def copy
    packet=Packet.new 0
    packet.sections=Marshal.load(Marshal.dump(self.sections))
    return packet
  end
  



end