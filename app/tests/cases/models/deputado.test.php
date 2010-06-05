<?php 
/* SVN FILE: $Id$ */
/* Deputado Test cases generated on: 2010-06-03 10:07:02 : 1275570422*/
App::import('Model', 'Deputado');

class DeputadoTestCase extends CakeTestCase {
	var $Deputado = null;
	var $fixtures = array('app.deputado');

	function startTest() {
		$this->Deputado =& ClassRegistry::init('Deputado');
	}

	function testDeputadoInstance() {
		$this->assertTrue(is_a($this->Deputado, 'Deputado'));
	}

	function testDeputadoFind() {
		$this->Deputado->recursive = -1;
		$results = $this->Deputado->find('first');
		$this->assertTrue(!empty($results));

		$expected = array('Deputado' => array(
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
		));
		$this->assertEqual($results, $expected);
	}
	
}
?>