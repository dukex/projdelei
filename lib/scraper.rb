#encoding: utf-8

require 'law_project_parser'
require 'models'

class Scraper
  def self.run!
    LawProjectParser.each do |project_law|
      if LawProject.all(:pl_id => project_law.pl_id).count == 0
        puts "Creating #{project_law.proposition}..."
        LawProject.create! :pl_id => project_law.pl_id,
                    :proposition => project_law.proposition,
                    :link => project_law.link,
                    :explication => project_law.explication
      end
    end
  end
end
