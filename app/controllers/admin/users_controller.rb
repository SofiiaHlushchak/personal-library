# frozen_string_literal: true

# app/controllers/admin/users_controller.rb
module Admin
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: %i[show edit update destroy]
    after_action :verify_authorized

    def index
      @users = policy_scope(User).sorted_by_first_name
      authorize User
    end

    def show
      authorize @user
    end

    def new
      @user = User.new
      authorize @user
    end

    def create
      @user = User.new(user_params)
      authorize @user
      @user.password = generate_random_password if @user.password.blank?

      if @user.save
        redirect_to admin_user_path(@user), notice: "User was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      authorize @user
    end

    def update
      authorize @user
      if @user.update_without_password(user_params)
        redirect_to admin_user_path(@user), notice: "User was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize @user
      @user.destroy
      redirect_to admin_users_path, notice: "User was successfully deleted."
    end

    private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :username, :birthdate, :role, :password,
                                   :password_confirmation)
    end

    def generate_random_password
      SecureRandom.hex(6)
    end
  end
end
