class Logger

  def log time, message
    puts "[%.3f] %s" % [time, message]
  end

end