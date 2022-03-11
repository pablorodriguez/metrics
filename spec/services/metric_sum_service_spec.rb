# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe MetricSumService do
  context 'when pass a metric value' do
    subject { MetricSumService.run(key: 'visitor') }

    before(:each) do
      Metric.create(key: 'visitor', value: 50)
      Metric.create(key: 'visitor', value: 20)
      Metric.create(key: 'visitor', value: 20, created_at: 1.5.hours.ago)
      Metric.create(key: 'erros', value: 20)
    end

    it 'then it is valid' do
      expect(subject).to be_valid
    end

    it 'then it return sum of last hour' do
      expect(subject.result).to eq(70)
    end

    it 'then it round up to nearest integer, 71.9 -> 72' do
      Metric.create(key: 'visitor', value: 1.9)
      expect(subject.result).to eq(72)
    end

    it 'then it round up to nearest integer, 71.5 -> 72' do
      Metric.create(key: 'visitor', value: 1.5)
      expect(subject.result).to eq(72)
    end

    it 'then it round down to nearest integer, 71.4 -> 71' do
      Metric.create(key: 'visitor', value: 1.45)
      expect(subject.result).to eq(71)
    end
  end

  context 'when do not pass a metric value' do
    subject { MetricSumService.run }

    it 'then it is invalid' do
      expect(subject).not_to be_valid
    end
  end
end
# rubocop:enable Metrics/BlockLength
