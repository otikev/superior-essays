class Core::Spider
    require 'rest-client'
    attr_reader :url

    def initialize(url)
        @url = url
        puts "Spider ready to crawl : #{url}"
    end

    def fetch
         #response = RestClient.get url
        response = RestClient::Resource.new(url,:verify_ssl => true).get
        response.body
    end
end