# frozen_string_literal: true

require 'multi_json'
require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    # Main class for Auth.sch strategy.
    class Authsch < OmniAuth::Strategies::OAuth2
      option :name, 'authsch'

      option :client_options,
             site: 'http://auth.sch.bme.hu',
             authorize_url: '/site/login',
             token_url: '/oauth2/token'

      option :authorize_params, grant_type: 'authorization_code'

      def authorize_params
        super.tap do |params|
          params[:scope] = request.params['scope'] if request.params['scope']
        end
      end

      uid { raw_info['internal_id'].to_s }

      info do
        {
          id: raw_info['internal_id'],
          email: raw_info['mail']
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        access_token.options[:parse] = :json

        url = '/api/profile'
        params = { params: { access_token: access_token.token } }
        @raw_info ||= MultiJson.decode(access_token.client.request(:get, url, params).body)
      end
    end
  end
end
