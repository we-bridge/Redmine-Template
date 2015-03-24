class Department < ActiveRecord::Base
  include Redmine::SafeAttributes
  unloadable
  belongs_to :head, :class_name => 'Person', :foreign_key => 'head_id'    
  has_many :people, :uniq => true, :dependent => :nullify

  acts_as_nested_set :order => 'name', :dependent => :destroy
  acts_as_attachable_global

  validates_presence_of :name 
  validates_uniqueness_of :name 

  safe_attributes 'name',
    'background',
    'parent_id',
    'head_id'

  def to_s
    name
  end

  # Yields the given block for each department with its level in the tree
  def self.department_tree(departments, &block)
    ancestors = []
    departments.sort_by(&:lft).each do |department|
      while (ancestors.any? && !department.is_descendant_of?(ancestors.last))
        ancestors.pop
      end
      yield department, ancestors.size
      ancestors << department
    end
  end  

  def css_classes
    s = 'project'
    s << ' root' if root?
    s << ' child' if child?
    s << (leaf? ? ' leaf' : ' parent')
    s
  end

  def allowed_parents
    return @allowed_parents if @allowed_parents
    @allowed_parents = Department.all
    @allowed_parents = @allowed_parents - self_and_descendants
    @allowed_parents << nil
    unless parent.nil? || @allowed_parents.empty? || @allowed_parents.include?(parent)
      @allowed_parents << parent
    end
    @allowed_parents
  end  

end
