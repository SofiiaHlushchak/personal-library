# frozen_string_literal: true

class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :birthdate, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
