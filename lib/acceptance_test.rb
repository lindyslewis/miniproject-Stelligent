require 'net/http'

class AcceptanceTest

  attr_accessor :url
  attr_reader :message

  def initialize url
    @url = url
    @message = 'Automation for the People'
  end

  def wait_for_http_to_be_ready(max_attempts:25)
    attempts = 1
    while attempts <= max_attempts
      code = self.return_http_code
      if code == '200'
        return true
      end
      sleep 10
      attempts = attempts + 1
    end
    raise RuntimeError, "ELB did not return 200 in #{max_attempts} attempts. Aborting deployment"
  end

  def return_http_code
    uri = URI(@url)
    http = Net::HTTP.new(uri.host, uri.port)
    request =   Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    response.code
  end

  def get_html
    uri = URI(@url)
    http = Net::HTTP.new(uri.host, uri.port)
    request =   Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    response.body
  end

  def html_contains_message? (html)
    if html.include? @message
      return true
    end
  end

end
