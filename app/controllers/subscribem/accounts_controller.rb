require_dependency "subscribem/application_controller"

module Subscribem
  class AccountsController < ApplicationController
    def new
      @account = Subscribem::Account.new
    end

    def create
      account = Subscribem::Account.create(account_params)
      redirect_to subscribem.root_url, notice: "Your account has been successfully created."
    end

    private
    def account_params
      params.require(:account).permit(:name)
    end
  end
end
