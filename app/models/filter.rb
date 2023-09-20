class Filter < ApplicationRecord
    validates_uniqueness_of :name
    enum status: { pending: 0, approved: 1, declined: 2 }

  serialize :values, JSON
  end
  