class Repository < ApplicationRecord
  belongs_to :user, optional: true
  validates :repository_name,
            presence: true
	acts_as_punchable
end

