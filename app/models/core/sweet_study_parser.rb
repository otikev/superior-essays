class Core::SweetStudyParser
    attr_reader :url

    FIELDS = [
        "/fields/engineering",
        "/fields/chemistry",
        "/fields/foreign-languages-spanish",
        "/fields/architecture-and-design",
        "/fields/mathematics"
    ]
    
    def initialize()
        @url = 'https://www.sweetstudy.com'
    end

    def parse_all
        FIELDS.each { |field|
            parse field
        }
    end

    def parse field
        puts "*****************************************************"
        scrapper = Core::Spider.new(url+field)
        response = scrapper.fetch
        doc = Nokogiri::HTML(response)

        uls = doc.xpath("//section")[0].xpath("div").xpath("ul")
        puts "count = #{uls.length}"

        questions = []

        for index in 5 ... uls.size
            puts "============================================"
            ul = uls[index]
            lis = ul.xpath("li")
            lis.each { |li|
                link = li.xpath("div").xpath("div").xpath("a")
                question = Hash.new
                question["link"] = "#{url}#{link.attr("href")}"
                question["title"] = link.text
                questions.push(question)
            }
        end

        #Fetch the first 3 questions that have no attachments
        no_attachments = []

        questions.each { |question|
            scrapper = Core::Spider.new(question["link"])
            response = scrapper.fetch
            doc = Nokogiri::HTML(response)
            divs = doc.at_css("div#main-question").xpath("section").xpath("div")
            _question = divs[2].xpath("div").xpath("div")
            attachments = divs[3].xpath("div").xpath("ul").xpath("li")

            if attachments.length == 0
                question["question"] = _question
                puts "***************"
                puts question["link"]
                puts "No attachments"
                puts "***************"
                if !exists?(question["link"])
                    no_attachments.push(question)
                    break if no_attachments.length >= 3
                end
            end
        }

        no_attachments.each { |q|
            save_to_db(q)
        }

    end

    def exists? link
        @content = Content.where(source: link).first
        return @content != nil
    end

    def save_to_db question
        puts "Saving question from #{question["link"]}"
        @content = Content.new
        @content.title = question["title"]
        @content.source = question["link"]
        @content.question = question["question"]
        @content.published = true
        @content.content_type=SEConstants::ContentType::ARCHIVE
        @content.save!
    end
end