require 'socket'
require 'json'

server = TCPServer.open(2000) 

loop {                 
  client = server.accept  
  request = client.read_nonblock(500).split("\n")
  header = request[0].split(" ")
  if File.exist?(header[1][1..-1])
		case header[0]
		when "GET"
	  	response = File.read header[1][1..-1]
	  	client.puts "HTTP/1.0 200 OK"
	  	client.puts ""
	    client.puts response
		when "POST"
		  params = JSON.parse(request[-1])
	  	response = File.read(header[1][1..-1])
	  	client.puts "HTTP/1.0 200 OK"
	  	client.puts ""
	    client.puts response.gsub("<%= yield %>", "<li>Name: #{params["name"]}</li><li>Email: #{params["email"]}</li>")
		else
			client.puts "Invalid Request. Please check spelling."
		end
  else
    client.puts "HTTP/1.0 404 Not Found"
  end
  
  client.close             
}
