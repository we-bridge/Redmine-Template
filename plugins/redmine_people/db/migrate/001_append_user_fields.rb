class AppendUserFields < ActiveRecord::Migration
  def self.up
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :skype, :string
    add_column :users, :birthday, :date
    add_column :users, :job_title, :string
    add_column :users, :company, :string
    add_column :users, :middlename, :string
    add_column :users, :gender, :smallint
    add_column :users, :twitter, :string
    add_column :users, :facebook, :string
    add_column :users, :linkedin, :string
    add_column :users, :background, :text
    add_column :users, :appearance_date, :date
    add_column :users, :department_id, :integer
  end

  def self.down
    remove_column :users, :phone
    remove_column :users, :address
    remove_column :users, :skype
    remove_column :users, :birthday
    remove_column :users, :job_title
    remove_column :users, :company
    remove_column :users, :middlename
    remove_column :users, :gender
    remove_column :users, :twitter
    remove_column :users, :facebook
    remove_column :users, :linkedin
    remove_column :users, :background
    remove_column :users, :appearance_date
    remove_column :users, :department_id
  end

end
