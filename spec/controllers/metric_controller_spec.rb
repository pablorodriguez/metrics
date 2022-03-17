# frozen_string_literal: true

require 'rails_helper'

describe MetricController, type: :request do
  describe 'POST' do
    context 'with valid parametres' do
      before(:each) do
        allow(MetricService).to receive(:add).and_call_original
      end

      it 'then return success' do
        post '/metric/errors', params: { value: 55 }
        expect(response).to have_http_status(:success)
      end

      it 'then return empty body' do
        post '/metric/errors', params: { value: 55 }
        expect(response.body).to eq('{}')
      end

      it 'create a new metrics with given attributes' do
        expect(MetricService).to receive(:add)
        post '/metric/errors', params: { value: 55 }
      end
    end
  end

  describe "GET" do

    context 'metric/:key/sum' do
      before(:each) do
        allow(MetricService).to receive(:sum).and_call_original
      end

      it 'then return success' do
        get '/metric/errors/sum'
        expect(response).to have_http_status(:success)
      end
    end
  end
end
