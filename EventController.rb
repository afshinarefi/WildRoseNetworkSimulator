require 'set'

class EventController
  @@nextEventID=0
  @currentTime=0
  @mods={}
  @events=SortedSet.new
  def initialize time, entity
    @time=time
    @entity=entity
  end

  def now
    @currentTime
  end

  def getID
    eventID=@@nextEventID
    @@nextEventID+=1
    return eventID
  end

  def newEvent mod, time
    eventID=getID
    @mods[eventID]=mod
    @events.add [time,eventID]
  end


end