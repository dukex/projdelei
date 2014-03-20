require 'iconv'
class Updater
  def self.now
    ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
    law = LawProject.first(:was_shared => false)
    if(law)
      Twitter.update("#{ic.iconv(law.tweet.clean)}", :include_entities => true)
      law.update(:was_shared => true)
    end
  end
end

