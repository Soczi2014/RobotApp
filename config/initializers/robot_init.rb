class RobotAccess
	def self.get_robot
		Driver.new "http://192.168.0.44:1237/", "2"
	end
end