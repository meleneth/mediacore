require 'test_helper'

require 'mediacore'

class MediacoreTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "simple file info" do
    info = FileInfo.new
    info.name = "file.txt"
    info.size = 1337
    info.path = "./slice/lamb"

    assert_equal("file.txt", info.name)
    assert_equal(1337, info.size)
    assert_equal("./slice/lamb", info.path)

    info = FileInfo.new("file.txt", 1337, "./slice/lamb")

    assert_equal("file.txt", info.name)
    assert_equal(1337, info.size)
    assert_equal("./slice/lamb", info.path)
  end

  test "Finds episode names" do
    farscape = Series.find_by_name('Farscape')

    file = FileInfo.new("S01E01.I.E.T.avi")
    core = mediacore_fill_in_series_info(farscape, file)
    assert_equal(farscape.name, file.series_name, "Assigns Farscape as series_name")
    assert_equal(1, file.season_no, "Season 1")
    assert_equal(1, file.episode_no, "Episode 1")

    file = FileInfo.new("Random Gibberish.avi")
    core = mediacore_fill_in_series_info(farscape, file)
    assert_equal(nil, file.series_name, "no info filled in")
    assert_equal(nil, file.season_no, "no info filled in")
    assert_equal(nil, file.episode_no, "no info filled in")

    file = FileInfo.new("S1E1.I.E.T.avi")
    core = mediacore_fill_in_series_info(farscape, file)
    assert_equal(farscape.name, file.series_name, "Assigns Farscape as series_name")
    assert_equal(1, file.season_no, "Season 1")
    assert_equal(1, file.episode_no, "Episode 1")

    #file = FileInfo.new("101.I.E.T.avi")
    #core = mediacore_fill_in_series_info(farscape, file)
    #assert_equal(farscape.name, file.series_name, "Assigns Farscape as series_name")
    #assert_equal(1, file.season_no, "Season 1")
    #assert_equal(1, file.episode_no, "Episode 1")

    file = FileInfo.new("1x01.I.E.T.avi")
    core = mediacore_fill_in_series_info(farscape, file)
    assert_equal(farscape.name, file.series_name, "Assigns Farscape as series_name")
    assert_equal(1, file.season_no, "Season 1")
    assert_equal(1, file.episode_no, "Episode 1")

    file = FileInfo.new("1x1.I.E.T.avi")
    core = mediacore_fill_in_series_info(farscape, file)
    assert_equal(farscape.name, file.series_name, "Assigns Farscape as series_name")
    assert_equal(1, file.season_no, "Season 1")
    assert_equal(1, file.episode_no, "Episode 1")
  end

end
