class Review < ActiveRecord::Base
  belongs_to :reviewable, polymorphic: true
  validates :reviewable_type, presence: true
  validates :reviewable_id, presence: true
end
