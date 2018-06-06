require_relative 'Port'
require_relative 'DummyModule'
require_relative 'EventController'

packet={dataSize: 1024}

eventController=EventController.new
port=Port.new eventController, 1024, nil
dummySender=DummyModule.new eventController
dummyReceiver=DummyModule.new eventController
port.connectStatic dummySender
port.connectDynamic dummyReceiver
port.receive packet, dummySender
eventController.newEvent port, 0
eventController.start
