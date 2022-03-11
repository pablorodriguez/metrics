# frozen_string_literal: true

require 'rails_helper'

describe Metric, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:key) }
    it { should validate_presence_of(:value) }
  end
end
