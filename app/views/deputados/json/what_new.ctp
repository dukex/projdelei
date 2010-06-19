{"projetos_de_leis":{
	<?php $i=0?>
	<?php foreach($new as $pl):
		$i += 1;  
			echo '"'.$pl['Deputado']['id'].'":{';
			echo '"url":"'.$pl['Deputado']['url'].'",';
			echo '"emenda":"'.htmlentities($pl['Deputado']['explicacao_emenda']).'",';
			echo '"data":"'.$pl['Deputado']['data_apresentacao'].'",';
			echo '"pl":"'.$pl['Deputado']['pl'].'"';
			
		echo '},';
	 endforeach;?>
	"count":<?php echo $i?>
	
	}
}