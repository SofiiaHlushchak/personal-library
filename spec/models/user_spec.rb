# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  birthdate              :date             not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  last_name              :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  let(:user_params) do
    {
      email: "user@example.com",
      password: "password123",
      password_confirmation: "password123",
      first_name: "John",
      last_name: "Doe",
      birthdate: "1990-01-01",
      username: "johndoe"
    }
  end

  subject { described_class.new(user_params) }

  describe "Validations" do
    context "when attributes are valid" do
      it "is valid with all required attributes" do
        expect(subject).to be_valid
      end
    end

    context "when required attributes are missing" do
      it "is invalid without a password" do
        subject.password = nil
        expect(subject).to_not be_valid
        expect(subject.errors[:password]).to include("Password is required")
      end

      it "is invalid without an email" do
        subject.email = nil
        expect(subject).to_not be_valid
        expect(subject.errors[:email]).to include("Email is required")
      end

      it "is invalid without a first_name" do
        subject.first_name = nil
        expect(subject).to_not be_valid
        expect(subject.errors[:first_name]).to include("First name is required")
      end

      it "is invalid without a last_name" do
        subject.last_name = nil
        expect(subject).to_not be_valid
        expect(subject.errors[:last_name]).to include("Last name is required")
      end

      it "is invalid without a birthdate" do
        subject.birthdate = nil
        expect(subject).to_not be_valid
        expect(subject.errors[:birthdate]).to include("Birthdate is required")
      end

      it "is invalid without a username" do
        subject.username = nil
        expect(subject).to_not be_valid
        expect(subject.errors[:username]).to include("Username is required")
      end
    end

    context "when attributes have incorrect format" do
      it "is invalid with an incorrectly formatted email" do
        subject.email = "invalid_email"
        expect(subject).to_not be_valid
        expect(subject.errors[:email]).to include("Email is invalid")
      end

      it "is invalid with a non-unique email" do
        create(:user, email: "user@example.com")
        expect(subject).to_not be_valid
        expect(subject.errors[:email]).to include("Email has already been taken")
      end

      it "is invalid with a short password" do
        subject.password = "short"
        subject.password_confirmation = "short"
        expect(subject).to_not be_valid
        expect(subject.errors[:password]).to include("Password is too short (minimum is 6 characters)")
      end

      it "is invalid if password and password_confirmation do not match" do
        subject.password_confirmation = "different_password"
        expect(subject).to_not be_valid
        expect(subject.errors[:password_confirmation]).to include("Passwords do not match")
      end

      it "is invalid with a non-unique username" do
        create(:user, username: "johndoe")
        expect(subject).to_not be_valid
        expect(subject.errors[:username]).to include("Username has already been taken")
      end
    end
  end
end
