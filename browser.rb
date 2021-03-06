require 'socket'
require 'json'
 
host = 'localhost'
port = 2000   

request = %Q{GET /index.html HTTP/1.0
From: someuser@gmail.com
User-Agent: HTTPTool/1.0
}

post = %Q{POST /thanks.html.erb HTTP/1.0
From: someuser@gmail.com
User-Agent: HTTPTool/1.0
Content-Type: text.txt
}

puts "Welcome to a rudimentary web browser! Please chose an action."
puts "1 << GET"
puts "2 << POST"
action = action = gets.chomp.downcase
until action == "1" || action == "2"
	puts "Oops! Please enter a valid number (1 or 2)"
	action = gets.chomp.downcase
end
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
  post +="Content-Length: #{info.to_s.length}\n" + "\n" + JSON.generate(info[:user])
  socket = TCPSocket.open(host,port)
  socket.puts post
end

while line = socket.gets
  puts line.chop  
end
