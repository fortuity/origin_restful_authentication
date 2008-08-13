class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.integer :role_id, :user_id, :null => false
      t.integer :updated_by
      t.timestamps
    end
    
    # Make sure the role migration file was generated first
    Role.create({
      :name => 'administrator'
    })
    # Add the default admin user
    # Be sure to change the password
    user = User.new({
      :login => ADMIN_LOGIN,
      :email => ADMIN_EMAIL_ADDRESS,
      :password => ADMIN_PASSWORD,
      :password_confirmation => ADMIN_PASSWORD
    })
    user.save(false)
    user = User.find_by_login(ADMIN_LOGIN)
    user.send(:activate!)

    role = Role.find_by_name('administrator')

    permission = Permission.new
    permission.role = role
    permission.user = user
    permission.save(false)
  end

  def self.down
    drop_table :permissions
    Role.find_by_name('administrator').destroy
    User.find_by_login(ADMIN_LOGIN).destroy
  end
end
