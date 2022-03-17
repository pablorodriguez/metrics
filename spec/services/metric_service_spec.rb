# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe MetricService do
  context 'when pass a metric value' do


    before(:each) do
      MetricService.reset
      travel_to(2.hours.ago) do
        MetricService.add(key: 'visitor', value: 20)
        MetricService.add(key: 'visitor', value: 22)
        MetricService.add(key: 'visitor', value: 23)
      end
      travel_back
      MetricService.add(key: 'visitor', value: 50)
      MetricService.add(key: 'visitor', value: 20)
      MetricService.add(key: 'erros', value: 20)
    end


    it 'then it return sum of last hour' do
      expect(MetricService.sum('visitor')).to eq(70)
    end

    it 'then it round up to nearest integer, 71.9 -> 72' do
      MetricService.add(key: 'visitor', value: 1.9)
      expect(MetricService.sum('visitor')).to eq(72)
    end

    it 'then it round up to nearest integer, 71.5 -> 72' do
      MetricService.add(key: 'visitor', value: 1.5)
      expect(MetricService.sum('visitor')).to eq(72)
    end

    it 'then it round down to nearest integer, 71.4 -> 71' do
      MetricService.add(key: 'visitor', value: 1.45)
      expect(MetricService.sum('visitor')).to eq(71)
    end
  end

end
# rubocop:enable Metrics/BlockLength
