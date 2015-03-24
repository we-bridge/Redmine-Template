require 'people_acl'

Rails.configuration.to_prepare do  
  require_dependency 'acts_as_attachable_global/init'

  require_dependency 'redmine_people/patches/user_patch'
  require_dependency 'redmine_people/patches/application_helper_patch'
  require_dependency 'redmine_people/patches/users_controller_patch'

  require_dependency 'redmine_people/hooks/views_layouts_hook'
end

module RedminePeople
  def self.available_permissions
    [:edit_people, :view_people, :add_people, :delete_people, :edit_departments, :delete_departments]
  end

  def self.settings() Setting[:plugin_redmine_people] end

  def self.users_acl() Setting.plugin_redmine_people[:users_acl] || {} end  
  
  def self.url_exists?(url)
    require_dependency 'open-uri'
    begin
      open(url)
      true
    rescue
      false
    end
  end
    
end
