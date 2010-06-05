<div class="deputados index">
<h2><?php __('Deputados');?></h2>
<p>
<?php
echo $paginator->counter(array(
'format' => __('Page %page% of %pages%, showing %current% records out of %count% total, starting on record %start%, ending on %end%', true)
));
?></p>
<table cellpadding="0" cellspacing="0">
<tr>
	<th><?php echo $paginator->sort('id');?></th>
	<th><?php echo $paginator->sort('num');?></th>
	<th><?php echo $paginator->sort('orgao');?></th>
	<th><?php echo $paginator->sort('autor');?></th>
	<th><?php echo $paginator->sort('data_apresentacao');?></th>
	<th><?php echo $paginator->sort('ememda');?></th>
	<th><?php echo $paginator->sort('despacho');?></th>
	<th><?php echo $paginator->sort('situacao');?></th>
	<th><?php echo $paginator->sort('created');?></th>
	<th><?php echo $paginator->sort('modified');?></th>
	<th class="actions"><?php __('Actions');?></th>
</tr>
<?php
$i = 0;
foreach ($deputados as $deputado):
	$class = null;
	if ($i++ % 2 == 0) {
		$class = ' class="altrow"';
	}
?>
	<tr<?php echo $class;?>>
		<td>
			<?php echo $deputado['Deputado']['id']; ?>
		</td>
		<td>
			<?php echo $deputado['Deputado']['num']; ?>
		</td>
		<td>
			<?php echo $deputado['Deputado']['orgao']; ?>
		</td>
		<td>
			<?php echo $deputado['Deputado']['autor']; ?>
		</td>
		<td>
			<?php echo $deputado['Deputado']['data_apresentacao']; ?>
		</td>
		<td>
			<?php echo $deputado['Deputado']['ememda']; ?>
		</td>
		<td>
			<?php echo $deputado['Deputado']['despacho']; ?>
		</td>
		<td>
			<?php echo $deputado['Deputado']['situacao']; ?>
		</td>
		<td>
			<?php echo $deputado['Deputado']['created']; ?>
		</td>
		<td>
			<?php echo $deputado['Deputado']['modified']; ?>
		</td>
		<td class="actions">
			<?php echo $html->link(__('View', true), array('action' => 'view', $deputado['Deputado']['id'])); ?>
			<?php echo $html->link(__('Edit', true), array('action' => 'edit', $deputado['Deputado']['id'])); ?>
			<?php echo $html->link(__('Delete', true), array('action' => 'delete', $deputado['Deputado']['id']), null, sprintf(__('Are you sure you want to delete # %s?', true), $deputado['Deputado']['id'])); ?>
		</td>
	</tr>
<?php endforeach; ?>
</table>
</div>
<div class="paging">
	<?php echo $paginator->prev('<< '.__('previous', true), array(), null, array('class'=>'disabled'));?>
 | 	<?php echo $paginator->numbers();?>
	<?php echo $paginator->next(__('next', true).' >>', array(), null, array('class' => 'disabled'));?>
</div>
<div class="actions">
	<ul>
		<li><?php echo $html->link(__('New Deputado', true), array('action' => 'add')); ?></li>
	</ul>
</div>
