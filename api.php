<?php 
include "fn.php";
$format = empty($_GET['format']) ? 'json' : $_GET['format'];
if($format == 'json'):
	header("Content-type: application/{$format}");
elseif($format == 'rss'):
	header("Content-type: application/xml");
endif;
$ano = empty($_GET['param'])?date("Y"):str_replace("/",null,$_GET['param']);

$url  = "http://www.camara.gov.br/sileg/Prop_Lista.asp?";
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
$yql =  urlencode("select * from html where url=\"{$url}\" AND xpath='//html/body/div/div[3]/div/div/div/div/form/table'");

$data_link = "http://query.yahooapis.com/v1/public/yql?q={$yql}&format=json&callback=";
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $data_link);
curl_setopt($ch, CURLOPT_FAILONERROR, true);
curl_setopt($ch, CURLOPT_AUTOREFERER, true);
curl_setopt($ch, CURLOPT_RETURNTRANSFER,true);
curl_setopt($ch, CURLOPT_TIMEOUT, 10);
$data = curl_exec($ch);
if (!$data) {
	echo "<br />cURL error number:" .curl_errno($ch);
	echo "<br />cURL error:" . curl_error($ch);
	exit;
}
$projeto = array();

$json_data = json_decode($data, true);
$json_data = empty($json_data)?array():json_decode($data, true);
if(!empty($json_data['query']['results']['table']['tbody'])):
	foreach($json_data['query']['results']['table']['tbody'] as $tbody):
		$thead = $tbody['tr'][0];
		$content = $tbody['tr']['1'];
		$id = empty($thead['td'][0]['input']['value'])?'ERROR-'.rand(1, 423223):explode(';',$thead['td'][0]['input']['value']);
		$id = "id-".$id[0];
	
		$projeto[$id]['info']['proposicao'] = $thead['td'][0]['a']['content'];
		$projeto[$id]['info']['link'] = 'http://www.camara.gov.br/sileg/'.$thead['td'][0]['a']['href'];
		$projeto[$id]['info']['orgao'] = $thead['td'][1]['p'];
		$projeto[$id]['info']['situacao'] = $thead['td'][2]['p'];
	
		$projeto[$id]['info']['autor'] = $content['td'][1]['p'][0]['content'];
		$projeto[$id]['content']['text'] = htmlspecialchars($content['td'][1]['p'][1]['content']);
		if($format == "xml"):
			$projeto[$id]['content']['text'] = "<![CDATA[".htmlspecialchars($projeto[$id]['content']['text'])."]]>";
		endif;
		$projeto[$id]['content']['despacho'] = empty($content['td'][1]['p'][2])?null:htmlspecialchars($content['td'][1]['p'][2]);
	endforeach;
else:
	$projeto = array();
endif;
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
endif;



