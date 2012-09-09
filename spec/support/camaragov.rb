module CamaraDotGov
  def fixture_with_nokogiri(name)
    Nokogiri::HTML(File.open("spec/support/fixture/#{name}.html").read, nil, "utf-8")
  end

  def fixture(name)
    ext = name.match("\.") ? "" : ".html"
    File.open("spec/support/fixture/#{name}#{ext}").read
  end
end


RSpec.configure do |config|
  config.include CamaraDotGov
end
