#--
# wx pay service function
#++
require 'securerandom'
require 'active_support/core_ext/hash/conversions'

module WxPay
  module Service
    class << self
      GATEWAY_URL = 'https://api.mch.weixin.qq.com'.freeze

      #调用统一下单
      def invoke_unifiedorder(params, options = {})
        params = {
          appid: WxPay.appid,
          mch_id: WxPay.mch_id,
          key: WxPay.key,
          nonce_str: SecureRandom.uuid.tr('-', '')
        }.merge(params)

        url = "#{gateway_url}/pay/unifiedorder"

        response_xml = WxPay::HttpApi.post(url, make_payload(params), options)
        response_hash = Hash.form_xml(response_xml)

        response_hash
      end

      private

      def gateway_url
        GATEWAY_URL
      end

      def make_payload(params, sign_type = WxPay::Sign::SIGN_TYPE_MD5)
        xmlify_payload(params, sign_type)
      end

      def xmlify_payload(params, sign_type = WxPay::Sign::SIGN_TYPE_MD5)
        sign = WxPay::Sign.generate(params, sign_type)
        "<xml>#{params.except(:key).sort.map { |k, v| "<#{k}>#{v}</#{k}>" }.join}<sign>#{sign}</sign></xml>"
      end
    end
  end
end