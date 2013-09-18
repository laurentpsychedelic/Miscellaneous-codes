require 'socket'

server = TCPServer.new(12345)
loop do
  Thread.start(server.accept) do | client |
    client.print "CURRENT TIME::" + Time.now.strftime("%c")
    client.close
  end
end
