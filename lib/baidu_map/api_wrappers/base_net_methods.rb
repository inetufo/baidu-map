module BaiduMap
  
  module BaseNetMethods

    def checked_baidu_response(&block)
      raise_net_status unless valid_response?
  
      raise_query_error unless valid_parsed_response?
  
      yield
    end

    def base_url
      base_request
    end

    def response
      @response ||= get_response
    end

    def valid_response?
      response.is_a?(Net::HTTPSuccess)
    end

    def valid_parsed_response?
      parsed_response["status"] == "OK"
    end

    def parsed_response
      @parsed_response ||= JSON.parse(response.body)
    end
    
    def get_response
      open(base_url).read
    end
    
  end
end