class Users::SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    if resource.buyer?
      dashboard_path
    else
      seller_dashboard_path
    end
  end
end 