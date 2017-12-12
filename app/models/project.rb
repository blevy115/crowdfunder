require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper

class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner
  has_and_belongs_to_many :categories

  validates :user, :title, :description, :goal, :start_date, :end_date, presence: true
  validates :goal, numericality: {greater_than: 0}
  validate :before_start_date_after_start_date

  def total_pledge
  pledges = Pledge.where("project_id = ?", id)
  total_amount = pledges.pluck(:dollar_amount).sum
  return total_amount
  end

  def before_start_date_after_start_date
    if :start_date > :created_at && :end_date > :start_date
      errors.add(start_date: "project must be added before #{Date.now}", end_date: "project must have end date before #{:start_date}")
    end
  end

  def time_left
    # seconds_left = end_date - DateTime.now.utc
    # mm, ss = seconds_left.divmod(60)
    # hh, mm = mm.divmod(60)
    # dd, hh = hh.divmod(24)
    # return "%d days, %d hours" % [dd, hh]

    return "#{(end_date > DateTime.now.utc) ? time_ago_in_words(end_date) : 'past deadline'}"
  end

end
