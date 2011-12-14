require 'childprocess' 
require 'timeout' 
require 'rest-client' 

server = ChildProcess.build("rackup", "--port", "8080") 
server.start 
Timeout.timeout(3) do 
  loop do 
    begin 
      RestClient.get('http://localhost:8080')
      break 
    rescue Errno::ECONNREFUSED => try_again 
      sleep 0.1 
    end 
  end 
end 
at_exit do 
  server.stop
end
