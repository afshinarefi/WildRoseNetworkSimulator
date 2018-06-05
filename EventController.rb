require 'set'

class EventController

  @currentTime=0
  @mods={}
  @events=SortedSet.new

  def now
    @currentTime
  end

  def newEvent mod, time
    id=mod.id
    @mods[id]=mod
    @events.add [time,id]
  end


end