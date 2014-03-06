class PaymentGateway
	def self.get
		gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
            :login => '7KngUP64h',
            :password => '5V6cCpz9T6P56zGT')
	end
end

