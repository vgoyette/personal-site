class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :summary
      t.text :body_markdown, null: false
      t.string :url
      t.datetime :published_at

      t.timestamps
    end
    add_index :projects, :slug, unique: true
    add_index :projects, :published_at
  end
end
