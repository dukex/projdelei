<div class="deputados form">
<?php echo $form->create('Deputado');?>
	<fieldset>
 		<legend><?php __('Edit Deputado');?></legend>
	<?php
		echo $form->input('id');
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
		<li><?php echo $html->link(__('Delete', true), array('action' => 'delete', $form->value('Deputado.id')), null, sprintf(__('Are you sure you want to delete # %s?', true), $form->value('Deputado.id'))); ?></li>
		<li><?php echo $html->link(__('List Deputados', true), array('action' => 'index'));?></li>
	</ul>
</div>
