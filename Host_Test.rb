require_relative 'Link'
require_relative 'Port'
require_relative 'DummyModule'
require_relative 'EventController'
require_relative 'Switch'
require_relative 'NetworkInterfaceCard'
require_relative 'Packet'
require_relative 'Host'

eventController=EventController.new
host=Host.newSimpleHost eventController, 512
nic=host.getNetworkInterfaceCards[0]
port1=nic.getPort
dummySender=DummyModule.new eventController, "Sender1"
dummyReceiver1=DummyModule.new eventController, "Receiver1"
dummyReceiver2=DummyModule.new eventController,"Receiver2"
link=Link.new eventController, 0
switch=Switch.new eventController
port2=switch.addPort 'P0', 1024
port3=switch.addPort 'P1', 1024
port4=switch.addPort 'P2', 1024
link.connectCableX port1
link.connectCableY port2
port3.connectDynamic dummyReceiver1
port4.connectDynamic dummyReceiver2

packet=Packet.new 2000
packet.sections[:relay]={nic.getMacAddress => [port3.getMacAddress]}

host.receive packet, nil

eventController.start
