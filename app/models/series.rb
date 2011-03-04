class Series < ActiveRecord::Base
  has_many :episodes

  def episode_count
    return episodes.count
  end
end
