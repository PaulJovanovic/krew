class CreateGroupsInterests < ActiveRecord::Migration
  def change
    create_table :groups_interests do |t|
      t.integer :group_id
      t.integer :interest_id
    end
  end
end
