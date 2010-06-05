<?php
class Deputado extends AppModel {

	var $name = 'Deputado';
	var $validate = array(
		'id' => array('notempty'),
		'num' => array('notempty'),
		'orgao' => array('notempty'),
		'autor' => array('notempty'),
		'data_apresentacao' => array('date'),
		'ememda' => array('notempty')
	);

}
?>