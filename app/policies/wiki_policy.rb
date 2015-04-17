class WikiPolicy < ApplicationPolicy
  def update?
    user.present?
  end

  def show?
    !record.private? || user.present?
  end
end