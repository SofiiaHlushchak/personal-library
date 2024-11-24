# frozen_string_literal: true

class BookPolicy < ApplicationPolicy
  def destroy?
    user.admin?
  end
end
