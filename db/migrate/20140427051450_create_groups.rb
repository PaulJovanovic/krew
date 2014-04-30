class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer   :admin_id
      t.string    :name
      t.string    :tagline
      t.string    :gender
      t.string    :seeking_gender
      t.integer   :location_id
      t.datetime  :start_date
      t.datetime  :end_date
      t.timestamps
    end

    add_index :groups, :gender
    add_index :groups, :seeking_gender
    add_index :groups, :location_id
  end
end
