module DepartmentsHelper
  def department_tree(departments, &block)
    Department.department_tree(departments, &block)
  end

  def parent_department_select_tag(department)
    selected = department.parent if department
    # retrieve the requested parent department
    parent_id = (params[:department] && params[:department][:parent_id]) || params[:parent_id]
    if parent_id
      selected = (parent_id.blank? ? nil : Department.find(parent_id))
    end
    departments = department ? department.allowed_parents.compact : Department.all
    options = ''
    options << "<option value=''></option>" 
    options << department_tree_options_for_select(departments, :selected => selected)
    content_tag('select', options.html_safe, :name => 'department[parent_id]', :id => 'department_parent_id')
  end  

  def department_tree_options_for_select(departments, options = {})
    s = ''
    department_tree(departments) do |department, level|
      name_prefix = (level > 0 ? '&nbsp;' * 2 * level + '&#187; ' : '').html_safe
      tag_options = {:value => department.id}
      if department == options[:selected] || (options[:selected].respond_to?(:include?) && options[:selected].include?(department))
        tag_options[:selected] = 'selected'
      else
        tag_options[:selected] = nil
      end
      tag = options[:tag] || 'option'
      tag_options.merge!(yield(department)) if block_given?
      s << content_tag(tag, name_prefix + h(department), tag_options)
    end
    s.html_safe
  end  

  def department_tree_links(departments, options = {})
    s = ''
    s << "<ul class='department-tree'>"
    s << "<li> #{link_to l(:label_people_all), {}} </li>"
    department_tree(departments) do |department, level| 
      name_prefix = (level > 0 ? ('&nbsp;' * 2 * level + '&#187; ') : '')
      s << "<li>" + name_prefix + link_to(department.name, {:department_id => department.id}, :class => "#{'selected' if @department && department == @department}")
      s << "</li>"                          
    end 
    s << "</ul>"
    s.html_safe   
  end

end
