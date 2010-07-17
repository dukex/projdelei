require 'rubygems'
require 'sinatra'
require 'twitter_oauth'
require 'haml'
require 'yaml'
require 'hpricot'
require 'open-uri'
require 'models'

configure do
  @@config = YAML.load_file("config.yml") rescue nil || {}
end

before do
  @client = TwitterOAuth::Client.new(
    :consumer_key => ENV['CONSUMER_KEY'] || @@config['consumer_key'],
    :consumer_secret => ENV['CONSUMER_SECRET'] || @@config['consumer_secret'],
    :token =>  @@config['token'],
    :secret =>  @@config['secret']
  )
 
 
  #Scrap
  url = "http://www.camara.gov.br/sileg/Prop_Lista.asp?"
  url << "Sigla=PL&"
  url << "Numero=&" 
  url << "Ano=2010&" 
  url << "Autor=&" 
  url << "Relator=&" 
  url << "dtInicio=&" 
  url << "dtFim=&" 
  url << "Comissao=&" 
  url << "Situacao=&" 
  url << "Ass1=&" 
  url << "Ass2=&" 
  url << "Ass3=&" 
  url << "co1=&" 
  url << "co2=&" 
  url << "OrgaoOrigem=todos"
  camara = Hpricot(open(url, "User-Agent" => "Emerson Vinicius .|.").read)
  (camara/"body/div/div[3]/div/div/div/div/form/table/tbody").each do |pl|
    @sileg = pl.search("//input[@name='chkListaProp']").attr("value").split(";")
    @id = @sileg[0]
    if !exist? :id => @id
      @orgao = (pl/"tr[1]/td[2]").inner_html
      @situacao = (pl/"tr[1]/td[3]").inner_html
      @autor = (pl/"tr[2]/td[2]/p[1]")
      
      url_detalhe = "http://www.camara.gov.br/sileg/Prop_Detalhe.asp?id=#{@id}"
      
      detalhes_pl =  Hpricot(open(url_detalhe, "User-Agent" => "Emerson Vinicius Bot").read)
    
      (detalhes_pl/"body/div/div[3]/div/div/div/div").each do |porcaria|
        
        @pl = (porcaria/"div[2]/p[1]/a").inner_html
        @data = (porcaria/"div[3]/p[1]").inner_html.split("</span>")[1]
        
        (porcaria/"p").each do |possives_emenda|
          
          if possives_emenda.to_s.match('Explica&ccedil;&atilde;o da Ementa:')
            @explicacao = possives_emenda.inner_html.split("</span>")[1].to_s
          else
            @emenda = (porcaria/"> p").first.inner_html.split("</span>")[1]
          end
          
        end
        
        @emenda = @explicacao if @explicacao    
        @explicacao = nil
        
      end
    end
  end
 
  
end

get '/' do
  haml :index
end

get '/scrap' do
  
end

helpers do    
  def exist?(options = {})
    @data = ProjectOfLaw.first(:id => options[:id]) 
    if @data
      return true
    else
      return false
    end
  end
end