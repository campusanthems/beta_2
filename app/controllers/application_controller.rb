class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :refresh_nav
  
  helper_method :next_track

  include SessionsHelper

  private

  	def refresh_nav
    	refresh_dom_with_partial 'div#Menu', 'layouts/menu'
  	end

end
