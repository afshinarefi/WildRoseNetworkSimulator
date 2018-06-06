class Service < Module

  def receive packet, host
    for dest in packet[@name][host.getNIC.getMacAddress]
      packet[:destinationMAC]=dest
      host.receive packet, nil
    end
  end

end