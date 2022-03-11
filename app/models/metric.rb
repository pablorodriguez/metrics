# frozen_string_literal: true

class Metric < ApplicationRecord
  # == Validations
  validates :value, :key, presence: true
end
