require_relative 'Address'

class MAC < Address
  
  def initialize
    @currentAddress=1
  end

  def getAddress
    address=@currentAddress
    @currentAddress+=1
    return format address
  end

  def format number
    bytes=[]
    for i in 5.downto(0)
      bytes << (0xFF & (number >> 8*i))
    end
    "%2X:%2X:%2X:%2X:%2X:%2X" % bytes
  end

end