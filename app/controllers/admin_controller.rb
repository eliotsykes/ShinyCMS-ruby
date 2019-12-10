# Base class for admin controllers
class AdminController < ApplicationController
  include Pundit
  include AdminAreaHelper

  before_action :check_admin_ip_list
  before_action :authenticate_user!

  layout 'admin/layouts/admin_area'

  # TODO: Add a user-setting so admins can set their preferred landing page
  # TODO: If no preference is set, redirect based on user's ACL:
  #       user.can?( 'list_blog_posts' ) to Blog admin section, etc
  def index
    authorize :admin

    redirect_to admin_pages_path
  end

  private

  # Check whether a list of permitted admin IP addresses has been defined,
  # and if one has, then redirect anybody not coming from one of those IPs.
  def check_admin_ip_list
    allowed = Setting.get I18n.t( 'admin.settings.admin_ip_list' )
    return if allowed.blank?

    return if allowed.strip.split( /\s*,\s*|\s+/ ).include? request.remote_ip

    redirect_to root_path
  end
end
