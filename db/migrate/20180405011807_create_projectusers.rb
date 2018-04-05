class CreateProjectusers < ActiveRecord::Migration[5.1]
  def change
    create_table :projectusers do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :project, foreign_key: true
      t.boolean :creator
      t.boolean :collaborator

      t.timestamps
    end
  end
end
