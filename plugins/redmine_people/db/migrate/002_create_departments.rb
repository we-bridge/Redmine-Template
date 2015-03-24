class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.integer   :parent_id, :default => nil
      t.integer   :lft, :default => nil
      t.integer   :rgt, :default => nil
      t.string    :name
      t.text      :background
      t.integer   :head_id
      t.timestamps
    end
    add_index :departments, [:parent_id, :lft, :rgt]
    add_index :departments, :head_id
  end

end
