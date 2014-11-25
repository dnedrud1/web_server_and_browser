require 'socket'
require 'json'
 
host = 'localhost'     # The web server
port = 2000            # Default HTTP port

request = %Q{GET /index.html HTTP/1.0
From: someuser@jmarshall.com
User-Agent: HTTPTool/1.0
}

post = %Q{POST /thanks.html HTTP/1.0
From: frog@jmarshall.com
User-Agent: HTTPTool/1.0
Content-Type: text.txt
}

puts "Welcome to a rudimentary web browser! Please chose an action."
puts "1 << GET"
puts "2 << POST"
action = gets.chomp.downcase
case action
when "1"
  socket = TCPSocket.open(host,port)
  socket.puts request
when "2"
  puts "Please enter a name:"
  name = gets.chomp
  puts "Please enter an email:"
  email = gets.chomp
  info = {:user => {:name=> name, :email=> email} }
  post += "\n" + JSON.generate(info[:user])
  socket = TCPSocket.open(host,port)
  socket.puts post
end

while line = socket.gets   # Read lines from the socket
  puts line.chop      # And print with platform line terminator
end
# Split response at first blank line into headers and body
#headers,body = response.split("\r\n\r\n", 2) 
#print body                          # And display it
