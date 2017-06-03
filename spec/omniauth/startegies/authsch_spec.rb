# frozen_string_literal: true

require 'spec_helper'
require 'omniauth-authsch'

describe OmniAuth::Strategies::Authsch do
  let(:request) { double('Request', params: {}, cookies: {}, env: {}) }
  let(:app) do
    lambda do
      [200, {}, ['Hello.']]
    end
  end

  subject do
    OmniAuth::Strategies::Authsch.new(app, 'appid', 'secret', @options || {}).tap do |strategy|
      allow(strategy).to receive(:request) do
        request
      end
    end
  end

  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end

  describe '#client_options' do
    it 'has correct site' do
      expect(subject.client.site).to eq('http://auth.sch.bme.hu')
    end

    it 'has correct authorize_url' do
      expect(subject.client.options[:authorize_url]).to eq('/site/login')
    end

    it 'has correct token_url' do
      expect(subject.client.options[:token_url]).to eq('/oauth2/token')
    end
  end
end
