require 'socket'

server = TCPServer.open(2000)  # Socket to listen on port 2000

loop {                         # Servers run forever
  client = server.accept    # Wait for a client to connect 
  request = client.read_nonblock(500).split("\n")
  header = request[0].split(" ")
  case header[0]
  when "GET" 
    if File.exist?(header[1][1..-1])
    	response = File.readlines header[1][1..-1]
    	client.puts "HTTP/1.0 200 OK"
    	client.puts ""
      client.puts response.join("\n")
    else
      client.puts "HTTP/1.0 404 Not Found"
    end
  when "POST"
    p request
	else
	  puts "Invalid Request. Please check spelling."
  end
  
  client.close                 # Disconnect from the client
}
