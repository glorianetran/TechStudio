class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :summary
      t.text :description
      t.string :project_type
      t.string :skills_desired

      t.timestamps
    end
  end
end
