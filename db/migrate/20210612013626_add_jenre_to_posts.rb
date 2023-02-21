class AddJenreToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :jenre, :string
    add_column :posts, :title, :string
    add_column :posts, :who, :string
    add_column :posts, :published_year, :date
  end
end
