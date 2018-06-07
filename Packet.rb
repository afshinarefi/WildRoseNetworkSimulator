class Packet

  attr_reader :sections

  @@nextID=0

  def initialize dataSize
    @sections={dataSize:dataSize}
    @id=@@nextID
    @@nextID+=1
  end



end