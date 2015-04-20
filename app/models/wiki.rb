class Wiki < ActiveRecord::Base
  has_many :collaborators
  has_many :users, through: :collaborators

  validates :title, presence: true

  # default_scope { order('title ASC') }
  scope :by_title, -> { order('title ASC') }

  def downgrade_wikis
    update_attributes(:private => false)
  end

  def markdown_body
    render_as_markdown(self.body)
  end

  # def user_is_collaborator?(user)
  #   self.users.where('user_id == ?', user).exists?
  # end

  private

  def render_as_markdown(markdown)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end

end
