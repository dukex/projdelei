<?php
class DeputadosController extends AppController {

	var $name = 'Deputados';
	var $helpers = array('Html', 'Form');
	var $components = array('Curioso','RequestHandler');
	
	public function scrap()
	{	
		$this->params['named']['page'] = empty($this->params['named']['page'])? 1 : $this->params['named']['page'];
		$url = "http://www.camara.gov.br/sileg/Prop_Lista.asp?";
		$url .= "Pagina={$this->params['named']['page']}";
		$url .= "&Sigla=PL";
		$url .= "&Numero=";
		$url .= "&Ano=".date("Y");
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
		$_data = ($this->Curioso->scrap($url, "//html/body/div/div[3]/div/div/div/div/form/table/tbody"));
	
		$data_for_save = array();
		$last_id = $this->Deputado->find("first",array("order"=>"id DESC","limit"=>"1"));
		$last_id = $last_id['Deputado']['id'];
		$data = $_data['query']['results']['tbody'];

		foreach($data as $data_pl):
			$pl = array();
			$thead = $data_pl['tr'][0];
			$content = $data_pl['tr']['1'];
			$autor_partido = explode("-", $this->Curioso->tratar($content['td'][1]['p'][0]['content']));
			
			$pl['pl'] = $thead['td'][0]['a']['content'];
			$url_more_info = 'http://www.camara.gov.br/sileg/'.$thead['td'][0]['a']['href'];
			$pl['url'] = $url_more_info;
			$this->Curioso->format = "json";
			$more_info = $this->Curioso->scrap($url_more_info, '//*[@id="content"]');
			
			$id = explode("=",$thead['td'][0]['a']['href']);
			$pl['id'] = $id[1];
			if(is_array($more_info) and !empty($more_info['query']['results']['div'])):
				$more_info = $more_info['query']['results'];
				if(!empty($more_info['div']['div'][2]['p'][3]['a']['class'])):
					unset($more_info['div']['div'][2]['p'][3]['a']['class']);
				endif;
			
				$pl['link_integra'] = empty($more_info['div']['div'][1]['p'][0]['a'][0]['href']) ? empty($more_info['div']['div'][1]['p'][0]['a']['href']) ? null : $more_info['div']['div'][1]['p'][0]['a']['href'] : $more_info['div']['div'][1]['p'][0]['a'][0]['href'];
				
				$_data = $more_info['div']['div']['2']['p'][0]['content'];
				$data = explode("/",$_data);
				$data = $data[2].'-'.$data[1].'-'.$data[0];
				
				$pl['data_apresentacao'] = $this->Curioso->tratar($data);
			//	echo count($more_info['div']['p']);
				if(count($more_info['div']['p']) == 3):
					$pl['explicacao_emenda'] = $this->Curioso->tratar($more_info['div']['p'][0]['content']);
				else:
					$pl['explicacao_emenda'] = $this->Curioso->tratar($more_info['div']['p'][0]['content']);
				endif;
				//echo pr($pl['explicacao_emenda']);
			
				unset($more_info['div']['id']);
				unset($more_info['div']['script']);
				unset($more_info['div']['h2']);
				unset($more_info['div']['div']);
				unset($more_info['div']['p']);
			
			endif;
			
			$data_for_save[] = $pl;
		endforeach;
		
		krsort($data_for_save);
	
		$log = array();
		$status = array();
		foreach($data_for_save as $data):
			$save = $this->Deputado->save($data);
			if($save):
				$status[$data['id']] =  "Adicionado";
				$log[$data['id']] = "ok";
			else:
				$status[$data['id']] = "ERRO";
				$log[$data['id']] = "erro";
			endif;
		endforeach;
	
		$myFile = "pl.json";
		$fh = fopen(ROOT . DS . APP_DIR . DS."webroot". DS. $myFile, 'a+');
		fwrite($fh, "\n".json_encode($log).","."\n");
		fclose($fh);
		$this->set(compact('status'));
	}
	
	public function what_new()
	{
		if($this->params['url']['ext'] == "json"):
			$new =  $this->Deputado->find("all",array(
			 	'conditions' =>  array('Deputado.status_twitter' => 0),
				'order'=>'Deputado.created ASC'
			 ));
		else:
			 $this->paginate = array(
			 	'conditions' =>  array('Deputado.status_twitter' => 0),
				'order'=>'Deputado.created ASC'
			 );
			$new =  $this->paginate('Deputado');
		endif;
		$this->set(compact('new'));
	}
	public function update($id)
	{
		$this->Deputado->id = $id;
		$status = array();
	//	$status['Deputado']['status_twitter'] = 1
		if($this->Deputado->save(array("status_twitter"=>1))):
			echo "Atualizado";
		endif;
	}
	public function twitter_what_new($value='')
	{
		$new =  $this->Deputado->find("all",array(
		 	'conditions' =>  array('Deputado.status_twitter' => 0),
			'order'=>'Deputado.created ASC',
			'limit'=>3
		 ));
		$status = array();
		foreach($new as $pl):
			$username = 'PROJdeLei';
			$password = 'fubanga8';
			
			$info = "http://api.j.mp/v3/shorten?login=duke16&apiKey=R_3deaa9026c5828aae99c01df82478629&longUrl=".urlencode($pl['Deputado']['url'])."&format=txt";
			$text = $pl['Deputado']['explicacao_emenda'];
			$pl_text = $pl['Deputado']['pl'];
			$jmp_handle = curl_init();
			curl_setopt($jmp_handle, CURLOPT_URL, "$info");
			curl_setopt($jmp_handle, CURLOPT_FAILONERROR, true);
			curl_setopt($jmp_handle, CURLOPT_AUTOREFERER, true);
			curl_setopt($jmp_handle, CURLOPT_RETURNTRANSFER,true);
			curl_setopt($jmp_handle, CURLOPT_TIMEOUT, 10);
			$url_mini = curl_exec($jmp_handle);
			curl_close($jmp_handle);
			
			$tam = 140 - (strlen($pl_text) + strlen($url_mini) + 5);
			$message = $url_mini." ".$this->Curioso->tratar(utf8_decode(substr($text,0,$tam)))."... ".$pl_text;
			$url = 'http://twitter.com/statuses/update.xml';
			$twitter_handle = curl_init();
			curl_setopt($twitter_handle, CURLOPT_URL, "$url");
			curl_setopt($twitter_handle, CURLOPT_CONNECTTIMEOUT, 2);
			curl_setopt($twitter_handle, CURLOPT_RETURNTRANSFER, 1);
			curl_setopt($twitter_handle, CURLOPT_POST, 1);
			curl_setopt($twitter_handle, CURLOPT_POSTFIELDS, "status=$message");
			curl_setopt($twitter_handle, CURLOPT_USERPWD, "$username:$password");
			$buffer = curl_exec($twitter_handle);
			curl_close($twitter_handle);
			if (empty($buffer)) {
				$status[$pl_text] = "Error";
			} else {
				$map = Router::url("/deputados/update/".$pl['Deputado']['id']);
				$url = "http://".$_SERVER['SERVER_NAME']."/".$map;
			
				$update_handle = curl_init();
				curl_setopt($update_handle, CURLOPT_URL, "$url");
				curl_setopt($update_handle, CURLOPT_RETURNTRANSFER, 1);
				$update = curl_exec($update_handle);
				curl_close($update_handle);
			    $status[$pl_text] = "Success";
			}
		endforeach;
		$this->set(compact('status'));
	}
	function index() {
		$this->Deputado->recursive = 0;
		$this->set('deputados', $this->paginate());
	}
	

}
?>