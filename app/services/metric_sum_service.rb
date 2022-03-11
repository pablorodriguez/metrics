# frozen_string_literal: true

require 'active_interaction'

#
# Service that return sum off values in last 2 days
class MetricSumService < ActiveInteraction::Base
  LAST_HOURS = 1
  string :key

  def execute
    Metric.where(' key = ? AND created_at >= ?', key, LAST_HOURS.hours.ago).sum(:value).round
  end

end
