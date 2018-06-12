require_relative 'Link'
require_relative 'Port'
require_relative 'DummyModule'
require_relative 'EventController'
require_relative 'Switch'
require_relative 'NetworkInterfaceCard'
require_relative 'Packet'
require_relative 'Host'

SPEED=10*(2**20)
HOST_COUNT=3

eventController=EventController.new
hosts=[]

switch00=Switch.new eventController
switch01=Switch.new eventController
s00_p=switch00.addPort 'P0', SPEED
s01_p=switch01.addPort 'P0', SPEED
link=Link.new eventController, 0
link.connectCableX s00_p
link.connectCableY s01_p

for i in 1..HOST_COUNT
  host=Host.newSimpleHost eventController, SPEED
  s00_p=switch00.addPort "P#{i}", SPEED
  link=Link.new eventController, 0
  link.connectCableX s00_p
  link.connectCableY host.getNetworkInterfaceCards[0].getPort
  hosts << host
  host=Host.newSimpleHost eventController, SPEED
  s01_p=switch01.addPort "P#{i}", SPEED
  link=Link.new eventController, 0
  link.connectCableX s01_p
  link.connectCableY host.getNetworkInterfaceCards[0].getPort
  hosts << host
end

for hostSrc in hosts
  for hostDst in hosts
    if hostSrc!=hostDst
      packet=Packet.new 0
      sourceMac=hostSrc.getNetworkInterfaceCards[0].getPort.getMacAddress
      destinationMac=hostDst.getNetworkInterfaceCards[0].getPort.getMacAddress
      packet.sections[:relay]={sourceMac => [destinationMac]}
      hostSrc.receive packet, nil
    end
  end
end

eventController.start

eventController.resetCurrentTime

BIN={'h00':['h01','h02'],'h01':['h03','h05'],'h02':['h04'],'h03':[],'h05':[],'h04':[]}

relay={}
for k in BIN.keys
  v=BIN[k]
  dests=[]
  for d in v
    dests << hosts[d[1..2].to_i].getNetworkInterfaceCards[0].getPort.getMacAddress
  end
  relay[hosts[k[1..2].to_i].getNetworkInterfaceCards[0].getPort.getMacAddress]=dests
end

puts "--------------------------------------------------------------"

packet=Packet.new 2**20
packet.sections[:relay]=relay

hosts[0].receive packet, nil

eventController.start



eventController.resetCurrentTime

TREE={'h00':['h02','h04','h01','h03'],'h02':['h05'],'h04':[],'h01':[],'h03':[],'h05':[]}

relay={}
for k in TREE.keys
  v=TREE[k]
  dests=[]
  for d in v
    dests << hosts[d[1..2].to_i].getNetworkInterfaceCards[0].getPort.getMacAddress
  end
  relay[hosts[k[1..2].to_i].getNetworkInterfaceCards[0].getPort.getMacAddress]=dests
end

puts "--------------------------------------------------------------"

packet=Packet.new 2**20
packet.sections[:relay]=relay

hosts[0].receive packet, nil

eventController.start