module ApplicationHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def asset_url asset
    "#{request.protocol}#{request.host_with_port}#{asset_path(asset)}"
  end

end
