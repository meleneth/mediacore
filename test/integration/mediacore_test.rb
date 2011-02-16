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
  end
end
