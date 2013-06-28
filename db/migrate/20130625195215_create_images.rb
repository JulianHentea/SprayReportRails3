class CreateImages < ActiveRecord::Migration
  def up
    create_table :images do |t|
      t.binary :data,         null: false
      t.string :extension,    null: false
      t.string :content_type, null: false
      t.timestamps
    end
  end

  def down
    drop_table :images
  end
end
