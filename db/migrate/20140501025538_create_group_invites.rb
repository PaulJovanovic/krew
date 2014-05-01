class CreateGroupInvites < ActiveRecord::Migration
  def change
    create_table :group_invites do |t|
      t.integer :user_id
      t.integer :group_id
      t.timestamps
    end
  end
end
