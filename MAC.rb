class MAC < Address
  @@currentAddress=1

  def format number
    bytes=[]
    for i in 5.downto(0)
      bytes << (0xFF & (number >> 8*i))
    end
    "%2X:%2X:%2X:%2X:%2X:%2X" % bytes
  end

end