# frozen_string_literal: true

require 'active_interaction'

#
# Service that return sum off values in last 2 days
class MetricService
  @@metrics = Hash.new{|hash, key| hash[key] = []}

  def self.add(metric)
    # add the new metric to the top of the metric list
    # this garantee that metrics are sorted from newer to oldest
    @@metrics[metric[:key]].unshift({ time: Time.current, value: metric[:value].to_f })
  end

  def self.reset
    @@metrics = Hash.new{|hash, key| hash[key] = []}
  end


  def self.metrics
    @@metrics
  end

  #
  # To sum metrics from last hour
  # I iterate metrics, acumulate the value
  # and create a new array with the
  # metrics that belong to to the last hour
  # and overwrite current metrics.
  # I do this to reduce the memory size
  #
  def self.sum(key)
    last_time = 1.hour.ago
    sum = 0
    last_metrics = []
    metrics = @@metrics[key]
    metrics.each do |metric|
      if metric[:time] >= last_time
        last_metrics.unshift(metric)
        sum += metric[:value]
      else
        break
      end
    end
    @@metrics[key] = last_metrics
    sum.round
  end

end
