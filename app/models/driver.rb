class Driver 
	require 'open-uri'
	
	def initialize(url, key)
		@url = url
		@key = key
	end

	def run_commands(command_string)
		commands = command_string.scan /forward|backward|left|right|slow_forward|slow_backward|attack|run/
		commands.each do |cmd|
			command(cmd)
		end
	end
	# lock
	# Returns true if robot was locked successfuly
	def lock
		command("lock") || (@last_response=="API locked by #{@key}")
	end

	def run		
		command("run")
	end

	def forward	
		command("forward")
	end

	def backward	
		command("backward")
	end

	def slow_forward	
		command("slow_forward")
	end

	def slow_backward	
		command("slow_backward")
	end

	def left	
		command("left")
	end

	def right	
		command("right")
	end

	def attack	
		command("attack")
	end

	def proximity
		address = @url + "proximity"
		uri = URI(address)
		begin
			@show_proximity = Net::HTTP.get(uri)
		rescue Exception => e
			@last_response = "Connection broken"
		end
	end

	def command(cmd)	
		address = @url + @key + "/" + cmd
		uri = URI(address)
		begin
			@last_response = Net::HTTP.get(uri)
		rescue Exception => e
			@last_response = "Connection broken"
		end

		if @last_response == "OK" 
			return true	
		else 
			return false
		end
		#albo po prostu:
		# return @last_response == "OK"
		# albo jeszcze prościej
		# @last_response == "OK"

	end

	def last_response
		@last_response
	end


end
