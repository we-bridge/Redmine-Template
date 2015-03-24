module RedminePeople
  module Patches
    module UsersControllerPatch
      def self.included(base)
        base.send(:include, InstanceMethods)

        base.class_eval do
          before_filter :authorize_people, :only => :show
        end
      end

      module InstanceMethods
        def authorize_people
          deny_access unless User.current.allowed_people_to?(:view_people, @user)
        end

      end
    end
  end
end

unless UsersController.included_modules.include?(RedminePeople::Patches::UsersControllerPatch)
  UsersController.send(:include, RedminePeople::Patches::UsersControllerPatch)
end
