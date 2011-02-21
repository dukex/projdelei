require 'law_project'
class Scraper
  def self.run!
    LawProject.each do |project_law|
      begin
        Law.create! :pl_id => project_law.pl_id,
                    :proposition => project_law.proposition,
                    :link => project_law.link,
                    :explication => project_law.explication
      rescue
        next
      end
    end
  end
end
