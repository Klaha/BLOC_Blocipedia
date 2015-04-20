class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :collaborators
  has_many :wikis, through: :collaborators

  def admin?
    role == 'admin'
  end
 
  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end

  def upgrade_account
    update_attributes(role: 'premium', premium: Time.now)
  end

  def downgrade_account
    update_attributes(role: 'standard', premium: nil)
  end

  def premium_left
    30 - (DateTime.now.to_date - premium.to_date).to_i
  end
end
