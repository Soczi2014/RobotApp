class PaymentsController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@payments = current_user.payments
	end

	def new
		@credit_card = ActiveMerchant::Billing::CreditCard.new
		@payment = Payment.new
	end

	def create



		@gateway = PaymentGateway.get

		#Tworzony jest payment i ustawiana jest ilość minut
		@payment = Payment.new(params_payment)
		
		#dana płatność jest wykonywana przez danego użytkownika
		@payment.user = current_user

		#obliczmy cenę ze względu na ilość kupionych minut
		@payment.amount = @payment.credit_count * 100

		@credit_card = ActiveMerchant::Billing::CreditCard.new(params[:credit_card])

		if @credit_card.valid? && @payment.valid?

			@response = @gateway.purchase(@payment.amount, @credit_card)

			if @response.success?
				
				
				current_user.credit_count += @payment.credit_count

				#Jak zmieniamy naraz wiele pól modeli transakcji
				ActiveRecord::Base.transaction do
					@payment.save!
					current_user.save!

				end
				flash[:notice] = "Successful transaction"

			else
				flash[:notice] = "Transaction was not successful, please try again"
			end
		else

			flash[:error] = "Credit card is not valid"
			render 'new'

		end



	end
	
	protected

	def params_payment
		params.require(:payment).permit(:credit_count, :first_name, :last_name, :number, :month, :year, :verification_value)
	end
end
