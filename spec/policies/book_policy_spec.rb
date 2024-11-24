# frozen_string_literal: true

require "rails_helper"

RSpec.describe BookPolicy do
  let(:admin) { create(:admin) }
  let(:regular_user) { create(:user) }
  let(:book) { create(:book) }

  subject { described_class.new(user, book) }

  context "when user is an admin" do
    let(:user) { admin }

    it "allows the admin to destroy the book" do
      expect(subject.destroy?).to be true
    end
  end

  context "when user is not an admin" do
    let(:user) { regular_user }

    it "does not allow the non-admin user to destroy the book" do
      expect(subject.destroy?).to be false
    end
  end
end
