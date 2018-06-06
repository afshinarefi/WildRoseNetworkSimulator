require 'set'

class EventController

  def initialize
    @currentTime=0
    @mods={}
    @events=SortedSet.new
  end

  def now
    @currentTime
  end

  def newEvent mod, time
    id=mod.id
    @mods[id]=mod
    @events.add [time,id]
  end

  def start
    while @events.size!=0
      item=@events.take(1)
      @events.subtract item
      time, id=item[0]

      @currentTime=time
      @mods[id].notify
    end
  end
end