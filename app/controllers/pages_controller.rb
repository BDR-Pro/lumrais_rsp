class PagesController < ApplicationController
  
  skip_before_action :authenticate_user!, only: [:landing]

  def download
  end

  def quick_run
  end

  def infra_action
  end

  def landing
    return redirect_to sellers_path if user_signed_in?
  end

  def settings
    @user = current_user
    @seller = @user.seller if @user.seller?
  end
end
