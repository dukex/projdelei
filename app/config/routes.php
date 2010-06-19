<?php
	Router::parseExtensions('json','xml'); 
	Router::connect('/', array('controller' => 'pages', 'action' => 'display', 'home'));
	Router::connect('/pages/*', array('controller' => 'pages', 'action' => 'display'));
	Router::connect('/camara_dos_deputados/*', array('controller' => 'deputados', 'action' => 'index'));