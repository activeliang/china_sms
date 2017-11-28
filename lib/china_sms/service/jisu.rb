# encoding: utf-8

module ChinaSMS
  module Service
    module Jisu
      extend self

      URL = "http://api.jisuapi.com/sms/send"

      def to(phone, content, options)
        url = URI.parse(URL)
        post = Net::HTTP::Post.new(url.path)
        post.basic_auth(options[:username], options[:appkey])
        post.set_form_data({mobile: phone, content: content})

        socket = Net::HTTP.new(url.host, url.port)
        # socket.use_ssl = true
        response = socket.start {|http| http.request(post) }
        result JSON.parse(response.body)
      end

      def result(body)
        {
          success: body['error'] == 0,
          code: body['error'],
          message: body['msg'],
          test: body
        }
      end
    end
  end
end