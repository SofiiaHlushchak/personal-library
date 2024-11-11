# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Users", type: :request do
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

  let(:user) { create(:user) }

  describe "POST /users (Registration)" do
    context "with valid attributes" do
      it "registers a new user and redirects to root path" do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by(1)

        expect(response).to redirect_to(root_path)
        follow_redirect!

        expect(response.body).to include("Hello, johndoe!")
      end
    end

    context "with invalid attributes" do
      it "does not register user with missing password confirmation" do
        invalid_params = user_params.merge(password_confirmation: "")

        expect do
          post user_registration_path, params: { user: invalid_params }
        end.to_not change(User, :count)

        expect(response.status).to eq(422)
        expect(CGI.unescapeHTML(response.body)).to include("Passwords do not match")
      end

      it "does not register user with mismatched passwords" do
        invalid_params = user_params.merge(password: "password1234")

        expect do
          post user_registration_path, params: { user: invalid_params }
        end.to_not change(User, :count)

        expect(response.status).to eq(422)
        expect(CGI.unescapeHTML(response.body)).to include("Passwords do not match")
      end
    end
  end

  describe "POST /users/sign_in (Login)" do
    context "with valid credentials" do
      it "logs in the user and redirects to root path" do
        post user_session_path, params: { user: { email: user.email, password: user.password } }

        expect(response).to redirect_to(root_path)

        follow_redirect!

        expect(CGI.unescapeHTML(response.body)).to include("Hello, #{user.username}")
      end
    end

    context "with invalid credentials" do
      it "does not log in the user with incorrect password" do
        post user_session_path, params: { user: { email: user.email, password: "wrongpassword" } }

        expect(response.status).to eq(422)

        expect(CGI.unescapeHTML(response.body)).to include("Invalid Email or password.")
      end
    end
  end

  describe "DELETE /users/sign_out (Logout)" do
    before do
      sign_in user
    end

    it "logs out the user and redirects to root path" do
      delete destroy_user_session_path

      expect(response).to redirect_to(root_path)

      follow_redirect!

      expect(CGI.unescapeHTML(response.body)).to include("Signed out successfully.")
    end
  end
end
