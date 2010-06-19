<?php
/**
 * Curioso component
 *
 * Busca dados de uma pagina, precisando apenas passar o Xpath
 *
 * PHP 5
 *
 * Emerson Vinicius
 * No Copyright, okay!!! ;-)
 *
 * Licensed under The MIT License
 * Redistributions of files must retain the above copyright notice.
 *
 * @copyright     No Copyright, okay!!! ;-)
 * @link          http://evinicius.com/projects Emerson Vinicius projects
 * @package       duke
 * @subpackage    duke.curioso
 * @license       MIT License (http://www.opensource.org/licenses/mit-license.php)
 */

/**
 * Retorna Conteudo em JSON ou XML de alguma pagina
 *
 *
 * @package       duke
 * @subpackage    duke.curioso
 */
class CuriosoComponent extends Object {
/**
 * Criando instancia do curl
 */
	var $ch;

/**
 * Url do YQL
 */
	var $url_yql;

	var $format = "json";
/**
 * Acordando o Curioso
 *
 * @return void
 * @access public
 */
	function initialize() {
		$this->ch = curl_init();
		curl_setopt($this->ch ,CURLOPT_CONNECTTIMEOUT,0);
	}

/**
 * Vamos curiar :D
 *
 * @params $url      string   endereço para nosso curioso ir
 * @params $xpath    string   XPath que quer buscar
 * @params $is_array bollean  Se true retorna dados em Array, se false returna um Objeto
 * 
 */
	function scrap($url = "http://www.google.com.br/ig?hl=pt-BR", $xpath = '//htm/body', $is_array = true){
		$yql = urlencode("select * from html where url=\"{$url}\" AND xpath='{$xpath}' and browser=0");
		$this->url_yql = "http://query.yahooapis.com/v1/public/yql?q={$yql}&format={$this->format}&callback=";	
	
		if($this->format == "json"):
			return json_decode($this->espia(), $is_array);
		else:
			return $this->espia();
		endif;
	}
	
/**
 * Curiando...
 * 
 * @return $data json
 */
	public function espia()
	{
		curl_setopt($this->ch, CURLOPT_URL, $this->url_yql);
		curl_setopt($this->ch, CURLOPT_FAILONERROR, true);
		curl_setopt($this->ch, CURLOPT_AUTOREFERER, true);
		curl_setopt($this->ch, CURLOPT_RETURNTRANSFER,true);
		curl_setopt($this->ch, CURLOPT_TIMEOUT, 10);
		$data = curl_exec($this->ch);
		if (!$data) {
			echo "<br />cURL error number:" .curl_errno($this->ch);
			echo "<br />cURL error:" . curl_error($this->ch);
			exit;
		}
		return $data;
	}
	public function tratar($data)
	{
		return str_replace(array("\n","\r","\t"),null, $data);
	}
/**
 * Botando Curiso para dormir
 *
 * @param object $controller Instantiating controller
 * @access public
 */
	function shutdown(&$controller) {
		curl_close($this->ch);
	}
}






/*
include "fn.php";
$format = empty($_GET['format']) ? 'json' : $_GET['format'];
if($format == 'json'):
	header("Content-type: application/{$format}");
elseif($format == 'rss'):
	header("Content-type: application/xml");
endif;
$ano = empty($_GET['param'])?date("Y"):str_replace("/",null,$_GET['param']);
$url = "http://www.camara.gov.br/sileg/Prop_Lista.asp?";
$url .= "Sigla=PL";
$url .= "&Numero=";
$url .= "&Ano=".$ano;
$url .= "&Autor=";
$url .= "&Relator=";
$url .= "&dtInicio=";
$url .= "&dtFim=";
$url .= "&Comissao=";
$url .= "&Situacao=";
$url .= "&Ass1=";
$url .= "&Ass2=";
$url .= "&Ass3=";
$url .= "&co1=";
$url .= "&co2=";
$url .= "&OrgaoOrigem=todos";




$projetos = $projeto;
if($format == "json"):
echo "{\"projetos\": ".json_encode($projetos)."}";
elseif($format == "rss"):
echo '<?xml version="1.0"?>';
?>
<rss version="0.92">
<channel>
<title>PROJdeLei</title>
<link>http://twitter.com/projedelei</link>
<description>Um twitter que posta novas leis/projetos da camara</description>
<lastBuildDate><?php echo date("D, d M Y H:i:s e")?></lastBuildDate>
<?php foreach($projetos as $_id=>$projeto):?>
<?php $id = explode("-", $_id);?>
<item>
<title><?php echo $projeto['info']['proposicao']?></title>
<link><?php echo $projeto['info']['link']?></link>
<description><?php echo $projeto['content']['text']?></description>
<author><?php echo $projeto['info']['autor']?></author>
<category><?php echo $projeto['info']['orgao']?></category>
<link><?php echo $projeto['info']['link']?></link>
<guid><?php echo $id['1']?></guid>
<pubDate> </pubDate>
</item>
<?php endforeach?>
</channel>
</rss>

<?php
else:
include "ArrayToXml.php";
$data_ = new ArrayToXml();
echo $data_->toXml($projetos,"projetos");
endif;?>*/