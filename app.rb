require 'rubygems'
require 'sinatra'
require 'twitter_oauth'
require 'haml'
require 'yaml'
require 'hpricot'
require 'uri'
require 'open-uri'
require 'models'

set :logging, :true

configure do
  Log = Logger.new("log/sinatra.log")
  Log.level  = Logger::INFO 
  
  @@config = YAML.load_file("config.yml") rescue nil || {}
end

before do
  @client = TwitterOAuth::Client.new(
    :consumer_key => ENV['CONSUMER_KEY'] || @@config['consumer_key'],
    :consumer_secret => ENV['CONSUMER_SECRET'] || @@config['consumer_secret'],
    :token => @@config['token'],
    :secret => @@config['secret']
  )
end


get '/' do
  # TODO: Criar um layout para Index
  "ProjdeLei"
end

get '/scrapy' do
 scrapy
 "Yup \o/"
end

helpers do  
  def scrapy
    url = "http://www.camara.gov.br/sileg/Prop_Lista.asp?Sigla=PL&Ano=2010&OrgaoOrigem=todos"
    camara = Hpricot(open(url, "User-Agent" => "Dukes Bot").read) 
    pisanofreioze = 0

    (camara/"body/div/div[3]/div/div/div/div/form/table/tbody").each do |pl|
    
      sileg = pl.search("//input[@name='chkListaProp']").attr("value").split(";")
      id = sileg[0]
      pl = (pl/".iconDetalhe").inner_html

      if !exist? :sileg => id
  
        pisanofreioze += 1
        break unless pisanofreioze < 4

        url_detalhe = "http://www.camara.gov.br/sileg/Prop_Detalhe.asp?id=#{id}"
        query = "select * from html where url=\"" + url_detalhe + "\" and xpath='//body/div/div[3]/div/div/div/div/p'"

        yql = "http://query.yahooapis.com/v1/public/yql?q=" + URI.escape(query)

        detalhe_pl = Hpricot.XML(open(yql).read)
        emenda = ''

        (detalhe_pl/"query/results/p").each do |porcarias|
          if porcarias.to_s.match("Explicação da Ementa:")
            emenda = porcarias.inner_html.split("</span>")[1].to_s
          end
        end

        if emenda.length == 0
          emenda = (detalhe_pl/"query/results/p[1]").inner_html.split("</span>")[1].to_s
        end
        
        
        tweet = tweet pl, url_detalhe, emenda
        Log.info "====== #{tweet.length} ========"
        Log.info "#{tweet}"

=begin
        projdelei = ProjectOfLaw.create({
                      :sileg => id,
                      :tweet  => tweet,              
                    })
        if projdelei.save
          @client.update(tweet)
        end
=end
      end
    end
  end

  def exist?(options = {})
    @data = ProjectOfLaw.first(:sileg => options[:sileg]) 
    if @data
      return true
    else
      return false
    end
  end

  def tweet(pl, url, txt)
    url_min = shorten url
    return "#{url_min} #{txt[0,105]}... #{pl}".gsub( /[\n\r]/,' ').gsub('  ',' ')
  end

  def shorten(url)
    new_url = open("http://api.j.mp/v3/shorten?login=#{@@config['user_bitly']}&apiKey=#{@@config['key_bitly']}&longUrl=#{url}&format=txt").read
    return new_url
  end
end


