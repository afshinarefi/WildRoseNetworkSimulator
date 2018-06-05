###############################################################################
# Author: Afshin Arefi
#
# Licence: GPL
###############################################################################

require_relative 'Module'

class Switch < Module
  
  @addressResolutionTable={}
  @ioNames={}

  def initialize eventController
    super(eventController)
  end

  def addPort name, speed
    ioNumber=addIO Port.new speed, self
    @ioNames[ioNumber]=name
  end

  def process packet, ioNumber
    @addressResolutionTable[packet[:source]]=ioNumber
    if @addressResolutionTable.has_key? packet[:destination]
      buffers[@addressResolutionTable[packet[:destination]]].push packet
    else
      for buffer in buffers
        buffer.push packet
      end
    end
    @eventController.newEvent self,@eventController.now
  end

end
