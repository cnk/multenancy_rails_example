require_dependency "subscribem/application_controller"

module Subscribem
  class Account::SessionsController < Subscribem::ApplicationController
    def new
      @user = User.new
    end

    def create
      if env["warden"].authenticate(:scope => :user)
        redirect_to root_path, notice: "You are now signed in."
      else
        render :new, error: "Invalid email or password"
      end
    end
  end
end
