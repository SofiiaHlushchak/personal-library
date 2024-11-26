# frozen_string_literal: true

module Admin
  class CategoriesController < ApplicationController
    before_action :authenticate_user!
    after_action :verify_authorized, except: :index

    def index
      @categories = Category.all
      authorize @categories
    end

    def new
      @category = Category.new
      authorize @category
    end

    def create
      @category = Category.new(category_params)
      authorize @category

      if @category.save
        redirect_to admin_categories_path, notice: "Category was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @category = Category.find(params[:id])
      authorize @category

      @category.destroy
      redirect_to admin_categories_path, notice: "Category was successfully deleted."
    end

    private
    def category_params
      params.require(:category).permit(:name)
    end
  end
end
