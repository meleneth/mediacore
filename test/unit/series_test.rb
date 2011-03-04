require 'test_helper'

class SeriesTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "series info" do
    series = Series.find_by_name("Farscape")
    assert_equal("Farscape", series.name)
    
#    e = Episode.group("series_id, season_id")
#    puts e
  end
end
