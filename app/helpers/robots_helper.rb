module RobotsHelper
	def locking_status_information
		if @locked 
			"Udało się!"
		else
			"Nie udało się. Odp #{@robot.last_response}"
		end
	end

	def proximity_information
		@proximity
	end

	def robot_control_button(cmd)
		render partial: "robot_control_button", locals: {cmd: cmd}
	end
end
