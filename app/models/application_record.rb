# frozen_string_literal: true

#
# Base Active Record, Rails
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
