class AddFkCreatorIdToSounds < ActiveRecord::Migration
  def change
    add_foreign_key(:sounds, :users, column: :creator_id)
  end
end
