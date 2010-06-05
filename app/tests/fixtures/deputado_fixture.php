<?php 
/* SVN FILE: $Id$ */
/* Deputado Fixture generated on: 2010-06-03 10:07:02 : 1275570422*/

class DeputadoFixture extends CakeTestFixture {
	var $name = 'Deputado';
	var $table = 'deputados';
	var $fields = array(
		'id' => array('type'=>'integer', 'null' => false, 'default' => NULL, 'key' => 'primary'),
		'num' => array('type'=>'string', 'null' => false, 'default' => NULL, 'length' => 11),
		'orgao' => array('type'=>'string', 'null' => true, 'default' => NULL, 'length' => 20),
		'autor' => array('type'=>'string', 'null' => true, 'default' => NULL, 'length' => 50),
		'data_apresentacao' => array('type'=>'date', 'null' => false, 'default' => NULL),
		'ememda' => array('type'=>'text', 'null' => false, 'default' => NULL),
		'despacho' => array('type'=>'string', 'null' => true, 'default' => NULL),
		'situacao' => array('type'=>'string', 'null' => true, 'default' => NULL, 'length' => 20),
		'created' => array('type'=>'datetime', 'null' => false, 'default' => NULL),
		'modified' => array('type'=>'datetime', 'null' => false, 'default' => NULL),
		'indexes' => array()
	);
	var $records = array(array(
		'id'  => 1,
		'num'  => 'Lorem ips',
		'orgao'  => 'Lorem ipsum dolor ',
		'autor'  => 'Lorem ipsum dolor sit amet',
		'data_apresentacao'  => '2010-06-03',
		'ememda'  => 'Lorem ipsum dolor sit amet, aliquet feugiat. Convallis morbi fringilla gravida,phasellus feugiat dapibus velit nunc, pulvinar eget sollicitudin venenatis cum nullam,vivamus ut a sed, mollitia lectus. Nulla vestibulum massa neque ut et, id hendrerit sit,feugiat in taciti enim proin nibh, tempor dignissim, rhoncus duis vestibulum nunc mattis convallis.',
		'despacho'  => 'Lorem ipsum dolor sit amet',
		'situacao'  => 'Lorem ipsum dolor ',
		'created'  => '2010-06-03 10:07:02',
		'modified'  => '2010-06-03 10:07:02'
	),array(
		'id'  => 2,
		'num'  => 'Lorem ips',
		'orgao'  => 'Lorem ipsum dolor ',
		'autor'  => 'Lorem ipsum dolor sit amet',
		'data_apresentacao'  => '2010-06-03',
		'ememda'  => 'Lorem ipsum dolor sit amet, aliquet feugiat. Convallis morbi fringilla gravida,phasellus feugiat dapibus velit nunc, pulvinar eget sollicitudin venenatis cum nullam,vivamus ut a sed, mollitia lectus. Nulla vestibulum massa neque ut et, id hendrerit sit,feugiat in taciti enim proin nibh, tempor dignissim, rhoncus duis vestibulum nunc mattis convallis.',
		'despacho'  => 'Lorem ipsum dolor sit amet',
		'situacao'  => 'Lorem ipsum dolor ',
		'created'  => '2010-06-03 10:07:02',
		'modified'  => '2010-06-03 10:07:02'
	));
}
?>