module CamaraDotGov
  def fixture(name)
    Nokogiri::HTML(File.open("spec/support/fixture/#{name}.html"))
  end
end


RSpec.configure do |config|
  config.include CamaraDotGov
end

