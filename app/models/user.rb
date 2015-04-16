class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis

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
    update_attributes(role: 'premium')
  end

  def downgrade_account
    update_attributes(role: 'standard')
  end
end
