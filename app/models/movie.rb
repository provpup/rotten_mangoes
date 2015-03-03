class Movie < ActiveRecord::Base
  has_many :review
  
  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validates :description, presence: true
  validates :poster_image_url, presence: true
  validates :release_date, presence: true
  validate :release_date_in_the_future

  protected
    def release_date_in_the_future
      if release_date.present?
        errors.add(:release_date, "should probably be in the future") if release_date < Date.today
      end
    end
end
