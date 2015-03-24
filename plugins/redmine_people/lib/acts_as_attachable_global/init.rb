# $LOAD_PATH.unshift(File.dirname(__FILE__))
# 
# require "lib/acts_as_viewable"
# 
# $LOAD_PATH.shift


require File.dirname(__FILE__) + '/lib/acts_as_attachable_global'

 
unless ActiveRecord::Base.included_modules.include?( Redmine::Acts::AttachableGlobal)
  ActiveRecord::Base.send(:include,  Redmine::Acts::AttachableGlobal)  
end
