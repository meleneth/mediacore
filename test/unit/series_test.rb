require 'test_helper'

class SeriesTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "series info" do
    series = Series.find_by_name("Farscape")
    assert_equal("Farscape", series.name)
    
#    e = Episode.group("series_id, season_id")
#    puts e
  end

  test "arel" do
    farscape = Series.find_by_name("Farscape")

    e = Episode.arel_table
    farscape_episodes = e[:series_id].eq(farscape.id)
    series_episode_count = e.group(e[:series_id], e[:episode_no].count.as('episode_count'))
    

  
    puts farscape_episodes.to_sql

#   farscape_episodes.count

  end
end
