class Wiki < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true

  def downgrade_wikis
    update_attributes(:private => false)
  end

  def markdown_body
    render_as_markdown(self.body)
  end

  private

  def render_as_markdown(markdown)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end

end
