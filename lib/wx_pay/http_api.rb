require 'rest_client'

module WxPay
  module HttpApi
    def self.post(url, payload, opation = {})
      parms = {
        method: :post,
        url: url,
        payload: payload,
        headers: { content_type: :json, accept: :json },
        timeout: 20,
        open_timeout: 10
      }

      response = RestClient::Request.execute(default_params.merge(options))
    end
  end
end