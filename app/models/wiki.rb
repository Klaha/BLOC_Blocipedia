class Wiki < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true

  def downgrade_wikis
    update_attributes(:private => false)
  end

end
