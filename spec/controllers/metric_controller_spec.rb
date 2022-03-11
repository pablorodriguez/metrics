# frozen_string_literal: true

require 'rails_helper'

describe MetricController, type: :request do
  describe 'POST' do
    context 'with valid parametres' do
      before(:each) do
        allow(Metric).to receive(:create).and_call_original
      end

      it 'return success' do
        post '/metric/errors', params: { value: 55 }
        expect(response).to have_http_status(:success)
      end

      it 'create a new metrics with given attributes' do
        expect(Metric).to receive(:create)
        post '/metric/errors', params: { value: 55 }
      end
    end

    context 'with invalid parameters' do
      before(:each) do
        allow(Metric).to receive(:create).and_call_original
      end

      it 'return errors' do
        post '/metric/errors'
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET" do

    context '/:key/sum' do
      before(:each) do
        allow(MetricSumService).to receive(:run).and_call_original
      end

      it 'return success' do
        get '/metric/errors/sum'
        expect(response).to have_http_status(:success)
      end
    end

  end
end
