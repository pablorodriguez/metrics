# frozen_string_literal: true

require 'active_interaction'

#
# Service that return sum off values in last 2 days
class MetricService
  @@metrics = Hash.new{|hash, key| hash[key] = {}}

  def self.add(metric)
    @@metrics[metric[:key]][Time.current] = metric[:value].to_f
  end

  def self.reset
    @@metrics = Hash.new{|hash, key| hash[key] = {}}
  end


  def self.metrics
    @@metrics
  end

  def self.sum(key)
    last_time = 1.hour.ago
    sum = 0
    metrics = @@metrics[key]
    metrics.keys.reverse.each do |time|
      value = metrics[time]
      if time >= last_time
        sum += value
      else
        break
      end
    end
    sum.round
  end

end
