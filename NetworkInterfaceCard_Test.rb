require_relative 'Link'
require_relative 'Port'
require_relative 'DummyModule'
require_relative 'EventController'
require_relative 'Switch'
require_relative 'NetworkInterfaceCard'

packet={dataSize: 2000, destinationMAC: "00:00"}

eventController=EventController.new
nic=NetworkInterfaceCard.new eventController, 512
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
nic.connectSlot dummySender
port3.connectDynamic dummyReceiver1
port4.connectDynamic dummyReceiver2
nic.receive packet, dummySender
eventController.start
packet={dataSize: 2000, destinationMAC: "00:00:00:00:00:01", sourceMAC: "00:00"}
port3.receive packet, dummyReceiver1
eventController.start