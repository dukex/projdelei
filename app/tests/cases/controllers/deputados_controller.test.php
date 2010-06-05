<?php 
/* SVN FILE: $Id$ */
/* DeputadosController Test cases generated on: 2010-06-03 10:46:27 : 1275572787*/
App::import('Controller', 'Deputados');

class TestDeputados extends DeputadosController {
	var $autoRender = false;
}

class DeputadosControllerTest extends CakeTestCase {
	var $Deputados = null;

	function startTest() {
		$this->Deputados = new TestDeputados();
		$this->Deputados->constructClasses();
	}

	function testDeputadosControllerInstance() {
		$this->assertTrue(is_a($this->Deputados, 'DeputadosController'));
	}

	function endTest() {
		unset($this->Deputados);
	}
}
?>