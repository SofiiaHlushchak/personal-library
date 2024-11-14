class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.text :description
      t.integer :published_year
      t.integer :age_limit, null: false
      t.integer :pages, null: false

      t.timestamps
    end

    add_index :books, :title, unique: true
  end
end
