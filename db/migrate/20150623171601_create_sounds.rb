class CreateSounds < ActiveRecord::Migration
  def change
    create_table :sounds do |t|
      t.references :creator, index: true
      t.string :title
      t.string :file

      t.timestamps null: false
    end
  end
end
