# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserPolicy do
  let(:admin_user) { create(:admin) }
  let(:regular_user) { create(:user) }
  let(:user_record) { create(:user) }

  subject { described_class.new(user, user_record) }

  context "when user is an admin" do
    let(:user) { admin_user }

    it "allows the admin to access the index" do
      expect(subject.index?).to be true
    end

    it "allows the admin to view any user" do
      expect(subject.show?).to be true
    end

    it "allows the admin to create a user" do
      expect(subject.create?).to be true
    end

    it "allows the admin to update any user" do
      expect(subject.update?).to be true
    end

    it "allows the admin to destroy any user" do
      expect(subject.destroy?).to be true
    end
  end

  context "when user is not an admin" do
    let(:user) { regular_user }

    it "does not allow a regular user to access the index" do
      expect(subject.index?).to be false
    end

    it "allows a regular user to view their own profile" do
      subject = described_class.new(user, user)
      expect(subject.show?).to be true
    end

    it "does not allow a regular user to create a user" do
      expect(subject.create?).to be false
    end

    it "does not allow a regular user to update other users" do
      expect(subject.update?).to be false
    end

    it "does not allow a regular user to destroy other users" do
      expect(subject.destroy?).to be false
    end
  end

  context "when user is trying to access another user's profile" do
    let(:user) { regular_user }

    it "does not allow a regular user to view another user's profile" do
      expect(subject.show?).to be false
    end
  end
end
