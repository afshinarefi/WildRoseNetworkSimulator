###############################################################################
# Author: Afshin Arefi
#
# Licence: GPL
###############################################################################

class Module
  
  include Comparable

  @@nextID=0
  @eventController=nil
  @times=[]
  @outputs=[]
  @buffers=[]
  @ios=[]

  def <=> (item)
    self.id <=> item.id
  end

  def id
    @id
  end

  def initialize eventController
    @eventController=eventController
    @id=@@nextID
    @@nextID+=1
  end

  def addIO io
    @times.push nil
    @outputs.push nil
    @buffers.push []
    @ios.push io
    return @ios.size-1
  end

  def time packet
    return 0
  end

  def receive packet, io
    for i in 0...ios.size
      if io == ios[i]
        process packet, i
      end
    end
  end

  def process packet, ioNumber
  end

  def notify
    for i in 0...@outputs.size
      if @outputs[i]!=nil && @times[i]==@eventController.now
        @ios[i].receive(@outputs[i])
        @outputs[i]=nil
      end
    end
    for i in 0...@buffers.size
      if @outputs[i]!=nil && @buffers[i].size!=0
        @outputs[i]=@buffers[i].shift
        @times[i]=@eventController.now+time(@outputs[i])
        @eventController.newEvent self,@times[i]
      end
    end
  end
end