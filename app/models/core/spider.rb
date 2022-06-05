class Core::Spider
    require 'rest-client'
    attr_reader :url

    def initialize(url)
        @url = url
        puts "Spider ready to crawl : #{url}"
    end

    def fetch
        response = RestClient.get url
        puts "**** Response ****"
        puts "code : #{response.code}"
        puts "******************"
        response.body
    end
end