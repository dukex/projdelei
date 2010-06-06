<?php
class DeputadosController extends AppController {

	var $name = 'Deputados';
	var $helpers = array('Html', 'Form');
	var $components = array('Curioso');

	public function scrap_save()
	{	
		$this->params['named']['page'] = empty($this->params['named']['page'])? null : $this->params['named']['page'];
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
			
			$pl['id'] = $thead['td'][0]['a']['content'];
			$url_more_info = 'http://www.camara.gov.br/sileg/'.$thead['td'][0]['a']['href'];
			$pl['url'] = $url_more_info;
			$this->Curioso->format = "json";
			$more_info = $this->Curioso->scrap($url_more_info, '//*[@id="content"]');

		
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
				$pl['explicacao_emenda'] = $this->Curioso->tratar($more_info['div']['p'][1]['content']);
				
				unset($more_info['div']['id']);
				unset($more_info['div']['script']);
				unset($more_info['div']['h2']);
				unset($more_info['div']['div']);
				unset($more_info['div']['p']);
			
			endif;
			
			$data_for_save[] = $pl;
		endforeach;
		
		krsort($data_for_save);
		
		
		echo "<ul>";
		$log = array();
		foreach($data_for_save as $data):
			$save = $this->Deputado->save($data);
			if($save):
				echo "<li>".$data['id'].": <span style=\"color:#00F\"> OK </span></li>";
				$log[$data['id']] = "ok";
			else:
				echo "<li>".$data['id'].": <span style=\"color:#F00\"> ERRO </span></li>";
				$log[$data['id']] = "erro";
			endif;
		endforeach;
		echo "</ul>";
		$myFile = "pl.json";
		$fh = fopen(ROOT . DS . APP_DIR . DS."webroot". DS. $myFile, 'a+');
		fwrite($fh, json_encode($log).","."\n");
		fclose($fh);
		
		
    /*	foreach($data['query']['results']['tbody'] as $tbody):
			$id = empty($thead['td'][0]['input']['value'])?'ERROR-'.rand(1, 423223):explode(';',$thead['td'][0]['input']['value']);
			$id = "id-".$id[0];

			$projeto['info']['link'] = 'http://www.camara.gov.br/sileg/'.$thead['td'][0]['a']['href'];
			$projeto['info']['situacao'] = $thead['td'][2]['p'];

			$projeto['content']['text'] = htmlspecialchars($content['td'][1]['p'][1]['content']);
			
			$projeto['content']['despacho'] = 
			$data_for_save[] = $pl;
		endforeach;*/
		
		
	//	pr($data_for_save);
		/*
			[Deputado] => Array
			                (
			                    [id] => 1
			                    [data_apresentacao] => 0000-00-00
			                    [ememda] => 
			                    [despacho] => 
			                    [situacao] => 
			                    [created] => 0000-00-00 00:00:00
			                    [modified] => 0000-00-00 00:00:00
			                )
			
		 */
	}
	function index() {
		$this->Deputado->recursive = 0;
		$this->set('deputados', $this->paginate());
	}

	function view($id = null) {
		if (!$id) {
			$this->Session->setFlash(__('Invalid Deputado.', true));
			$this->redirect(array('action'=>'index'));
		}
		$this->set('deputado', $this->Deputado->read(null, $id));
	}

	function add() {
		if (!empty($this->data)) {
			$this->Deputado->create();
			if ($this->Deputado->save($this->data)) {
				$this->Session->setFlash(__('The Deputado has been saved', true));
				$this->redirect(array('action'=>'index'));
			} else {
				$this->Session->setFlash(__('The Deputado could not be saved. Please, try again.', true));
			}
		}
	}

	function edit($id = null) {
		if (!$id && empty($this->data)) {
			$this->Session->setFlash(__('Invalid Deputado', true));
			$this->redirect(array('action'=>'index'));
		}
		if (!empty($this->data)) {
			if ($this->Deputado->save($this->data)) {
				$this->Session->setFlash(__('The Deputado has been saved', true));
				$this->redirect(array('action'=>'index'));
			} else {
				$this->Session->setFlash(__('The Deputado could not be saved. Please, try again.', true));
			}
		}
		if (empty($this->data)) {
			$this->data = $this->Deputado->read(null, $id);
		}
	}

	function delete($id = null) {
		if (!$id) {
			$this->Session->setFlash(__('Invalid id for Deputado', true));
			$this->redirect(array('action'=>'index'));
		}
		if ($this->Deputado->del($id)) {
			$this->Session->setFlash(__('Deputado deleted', true));
			$this->redirect(array('action'=>'index'));
		}
	}

}
?>