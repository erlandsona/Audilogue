class CreateSounds < ActiveRecord::Migration
  def change
    create_table :sounds do |t|
      t.references :creator, index: true
      t.string :title
      t.text :url

      t.timestamps null: false
    end
  end
end
