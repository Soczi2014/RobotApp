class RobotsController < ApplicationController
	before_action :authenticate_user!
	before_filter :fetch_robot

	def show

	end

	def update
		if current_user.has_active_credit?
			run_commands
		else
			if current_user.has_any_credits?
				current_user.bill!
				run_commands
			else
				redirect_to new_payment_path
			end
		end
		
	end

	protected 

	def fetch_robot
		@robot = RobotAccess.get_robot
		@locked = @robot.lock 	
		@proximity = RobotAccess.get_robot.proximity	
	end

	def run_commands
		@robot.run_commands(params[:cmd])
		render :show
	end

end

=begin

class A
	def a
	end
	def self.b
	end
end

a = A.new
a.a
A.a nie!
A.b 
a.b nie!!!

jerzy = User.find "jerzy"
jerzy.find "tomek"
=end
