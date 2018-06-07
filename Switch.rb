###############################################################################
# Author: Afshin Arefi
#
# Licence: GPL
###############################################################################

require_relative 'Module'

class Switch < Module

  def initialize eventController
    super(eventController)
    @addressResolutionTable={}
    @ioNames={}
  end

  def addPort name, speed
    port=Port.new @eventController, speed
    ioNumber=addIO port
    @ioNames[name]=ioNumber
    port.connectStatic self
    return port
  end

  def getPort index
    @ios[index]
  end

  def process packet, ioNumber
    @addressResolutionTable[packet.sections[:sourceMAC]]=ioNumber
    if @addressResolutionTable.has_key? packet.sections[:destinationMAC]
      @buffers[@addressResolutionTable[packet.sections[:destinationMAC]]].push packet
    else
      for buffer in 0...@buffers.size
        if buffer!=ioNumber
          @buffers[buffer].push packet
        end
      end
    end
    @eventController.newEvent self,@eventController.now
  end

end
