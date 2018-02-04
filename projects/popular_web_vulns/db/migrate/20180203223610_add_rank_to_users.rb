class AddRankToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :rank, :integer
  end
end
