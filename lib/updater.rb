class Updater
  def self.now
     law = LawProject.first(:was_shared => false)
     Twitter.update("#{law.tweet.clean}", :include_entities => true)
     law.update(:was_shared => true)
  end
end

