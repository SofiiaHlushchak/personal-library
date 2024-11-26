# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admin::Users", type: :request do
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }

  before do
    sign_in admin
  end

  describe "GET /admin/users" do
    it "returns a successful response" do
      create_list(:user, 3)
      get admin_users_path
      expect(response).to be_successful
      expect(response.body).to include("Users")
    end
  end

  describe "GET /admin/users/:id" do
    it "returns a successful response" do
      get admin_user_path(user)

      expect(response).to be_successful
      expect(response.body).to include(user.first_name)
    end
  end

  describe "GET /admin/users/new" do
    it "returns a successful response" do
      get new_admin_user_path

      expect(response).to be_successful
      expect(response.body).to include("New User")
    end
  end

  describe "POST /admin/users" do
    context "with valid parameters" do
      it "creates a new user and redirects to user show page" do
        expect do
          post admin_users_path,
               params: { user: { first_name: "John", last_name: "Doe", email: "john@example.com", username: "john_doe",
                                 birthdate: "1990-01-01", password: "password123" } }
        end.to change(User, :count).by(1)

        expect(response).to redirect_to(admin_user_path(User.last))

        follow_redirect!

        expect(response.body).to include("User was successfully created.")
      end
    end

    context "with invalid parameters" do
      it "does not create a new user and re-renders the new template" do
        expect do
          post admin_users_path,
               params: { user: { first_name: "", last_name: "", email: "", username: "", birthdate: "", password: "" } }
        end.not_to change(User, :count)

        expect(response.body).to include("New User")
      end
    end
  end

  describe "GET /admin/users/:id/edit" do
    it "returns a successful response" do
      get edit_admin_user_path(user)

      expect(response).to be_successful
      expect(response.body).to include("Edit User")
    end
  end

  describe "PATCH /admin/users/:id" do
    context "with valid parameters" do
      it "updates the user and redirects to user show page" do
        patch admin_user_path(user), params: { user: { first_name: "Updated" } }

        expect(response).to redirect_to(admin_user_path(user))

        follow_redirect!

        expect(response.body).to include("User was successfully updated.")
      end
    end

    context "with invalid parameters" do
      it "does not update the user and re-renders the edit template" do
        patch admin_user_path(user), params: { user: { first_name: "" } }

        expect(user.reload.first_name).not_to eq("")
        expect(response.body).to include("Edit User")
      end
    end
  end

  describe "DELETE /admin/users/:id" do
    let!(:user) { create(:user) }
    it "deletes the user and redirects to users index" do
      expect do
        delete admin_user_path(user)
      end.to change(User, :count).by(-1)

      expect(response).to redirect_to(admin_users_path)

      follow_redirect!

      expect(response.body).to include("User was successfully deleted.")
    end
  end
end
