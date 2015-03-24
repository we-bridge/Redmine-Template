module RedminePeople
  module Hooks
    class ViewsLayoutsHook < Redmine::Hook::ViewListener
      def view_layouts_base_html_head(context={})
        return stylesheet_link_tag(:people, :plugin => 'redmine_people')
      end
    end
  end
end