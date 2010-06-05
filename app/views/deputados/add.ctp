<div class="deputados form">
<?php echo $form->create('Deputado');?>
	<fieldset>
 		<legend><?php __('Add Deputado');?></legend>
	<?php
		echo $form->input('num');
		echo $form->input('orgao');
		echo $form->input('autor');
		echo $form->input('data_apresentacao');
		echo $form->input('ememda');
		echo $form->input('despacho');
		echo $form->input('situacao');
	?>
	</fieldset>
<?php echo $form->end('Submit');?>
</div>
<div class="actions">
	<ul>
		<li><?php echo $html->link(__('List Deputados', true), array('action' => 'index'));?></li>
	</ul>
</div>
