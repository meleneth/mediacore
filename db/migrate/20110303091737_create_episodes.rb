class CreateEpisodes < ActiveRecord::Migration
  def self.up
    create_table :episodes do |t|
      t.string :name
      t.integer :episode_no
      t.integer :season_no
      t.integer :series_id
      t.string :imdb_id
      t.date :original_air_date
      t.text :synopsis

      t.timestamps
    end
  end

  def self.down
    drop_table :episodes
  end
end
