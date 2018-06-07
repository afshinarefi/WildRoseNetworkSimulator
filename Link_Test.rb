require_relative 'Link'
require_relative 'Port'
require_relative 'DummyModule'
require_relative 'EventController'

packet={dataSize: 2000}

eventController=EventController.new
port1=Port.new eventController, 1024
port2=Port.new eventController, 1024
dummySender=DummyModule.new eventController
dummyReceiver=DummyModule.new eventController
link=Link.new eventController, 0
link.connectCableX port1
link.connectCableY port2
port1.connectStatic dummySender
port2.connectStatic dummyReceiver
port1.receive packet, dummySender
eventController.start
