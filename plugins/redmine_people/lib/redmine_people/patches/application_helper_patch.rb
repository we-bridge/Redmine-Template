require_dependency 'application_helper'

module RedminePeople
  module Patches
    module ApplicationHelperPatch
      def self.included(base)
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable

          alias_method_chain :link_to_user, :people  
          alias_method_chain :avatar, :people   
        end
      end


      module InstanceMethods
        # include ContactsHelper

        def avatar_with_people(user, options = { })
          options[:width] = options[:size] || "50" unless options[:width]  
          options[:height] = options[:size] || "50" unless options[:height]  
          if user.blank? || user.is_a?(String) || (user.is_a?(User) && user.anonymous?)
            return avatar_without_people(user, options)
          end
          if user.is_a?(User) && (avatar = user.avatar)
            avatar_url = url_for :only_path => false, :controller => "people", :action => "avatar", :id => avatar, :size => options[:size]
            image_tag(avatar_url, options.merge({:class => "gravatar"}))
          elsif user.respond_to?(:facebook) &&  !user.facebook.blank?
            image_tag("https://graph.facebook.com/#{user.facebook.gsub('.*facebook.com\/','')}/picture?type=square#{'&return_ssl_resources=1' if (request && request.ssl?)}", options.merge({:class => "gravatar"}))
          elsif user.respond_to?(:twitter) &&  !user.twitter.blank?
            image_tag("https://api.twitter.com/1/users/profile_image?screen_name=#{user.twitter}&size=bigger", options.merge({:class => "gravatar"}))
          elsif !Setting.gravatar_enabled?
            image_tag('person.png', options.merge({:plugin => "redmine_people", :class => "gravatar"}))
          else  
            avatar_without_people(user, options)
          end

        end

        def link_to_user_with_people(user, options={})
          if user.is_a?(User)
            name = h(user.name(options[:format]))
            if user.active? && User.current.allowed_people_to?(:view_people, user)
              link_to name, :controller => 'people', :action => 'show', :id => user
            else
              name
            end
          else
            h(user.to_s)
          end
        end
        
      end
      
    end
  end
end

unless ApplicationHelper.included_modules.include?(RedminePeople::Patches::ApplicationHelperPatch)
  ApplicationHelper.send(:include, RedminePeople::Patches::ApplicationHelperPatch)
end
