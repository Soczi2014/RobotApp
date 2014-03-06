class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :payments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def has_active_credit?
    paid_at && Time.now - paid_at < 60.seconds
  end

  def has_any_credits?
    credit_count > 0
  end
  def bill!
    self.credit_count -= 1 
    self.paid_at = Time.now
    payments.build :amount => 0, :credit_count => -1, :user => self
    save
  end

end
=begin
current_user.payments = []
current_user.payments.build parametry_do_tworzenia_paymentu
current_user.payments = [nowy_payment]
current_user.save => zapiisze nowy_payment
=end

