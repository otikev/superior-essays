class DailyJob < ActiveJob::Base
    def perform(options)
        Core::SweetStudyParser.new.parse_all
    end
end