require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper

class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner

  validates :title, :description, :goal, :start_date, :end_date, :user, presence: true

  def time_left
    # seconds_left = end_date - DateTime.now.utc
    # mm, ss = seconds_left.divmod(60)
    # hh, mm = mm.divmod(60)
    # dd, hh = hh.divmod(24)
    # return "%d days, %d hours" % [dd, hh]

    return "#{(end_date > DateTime.now.utc) ? time_ago_in_words(end_date) : 'past deadline'}"
  end
end
