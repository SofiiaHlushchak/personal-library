# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admin::CategoriesController", type: :request do
  let(:user) { create(:admin) }

  before do
    sign_in user
  end

  describe "GET /admin/categories" do
    let!(:category) { create(:category) }
    it "returns a successful response and assigns categories" do
      get admin_categories_path

      expect(response).to have_http_status(:ok)

      expect(response.body).to include(category.name)
    end
  end

  describe "GET /admin/categories/new" do
    it "returns a successful response and renders the new template" do
      get new_admin_category_path

      expect(response).to have_http_status(:ok)

      expect(response.body).to include("<form")
    end
  end

  describe "POST /admin/categories" do
    context "with valid attributes" do
      it "creates a new category and redirects to categories index" do
        post admin_categories_path, params: { category: { name: "New Category" } }

        expect(Category.count).to eq(1)
        expect(response).to redirect_to(admin_categories_path)

        follow_redirect!

        expect(response.body).to include("Category was successfully created.")
      end
    end

    context "with invalid attributes" do
      it "does not create a new category and re-renders the new template" do
        post admin_categories_path, params: { category: { name: "" } }

        expect(Category.count).to eq(0)
        expect(response).to have_http_status(422)
        expect(response.body).to include("is required")
      end
    end
  end

  describe "DELETE /admin/categories/:id" do
    let(:category) { create(:category) }
    it "deletes the category and redirects to categories index" do
      delete admin_category_path(category)

      expect(Category.count).to eq(0)
      expect(response).to redirect_to(admin_categories_path)

      follow_redirect!

      expect(response.body).to include("Category was successfully deleted.")
    end
  end
end
