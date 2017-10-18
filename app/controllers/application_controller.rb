class ApplicationController < ActionController::Base
  before_action :authenticate_member!

  protect_from_forgery with: :exception

  def current_ability
    @current_ability ||= Ability.new(current_member)
  end

  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = "Unauthorized access. You are redirected to the home page."
    redirect_to main_app.root_url, :alert => exception.message
  end
end