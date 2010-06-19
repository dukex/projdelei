<div class="deputados index">
<h2><?php __('Projetos de Lei da Camara dos Deputados');?></h2>
<p>
<?php
echo $paginator->counter(array(
'format' => __('Pagina %page% de %pages%, mostrando %current% projetos de lei de %count% no total cadastrados, registro começando no %start%º, terminano no %end%º', true)
));
?></p>
<table cellpadding="0" cellspacing="0">
<tr>
	<th><?php echo $paginator->sort('PL','id');?></th>
	<th><?php echo $paginator->sort('Data de Apresentação','data_apresentacao');?></th>
	<th><?php echo $paginator->sort('Explicação da Emenda', 'explicacao_emenda');?></th>
	<th><?php echo $paginator->sort('status_twitter');?></th>
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
			<?php echo $deputado['Deputado']['data_apresentacao']; ?>
		</td>
		<td>
			<?php echo $deputado['Deputado']['explicacao_emenda']; ?>
		</td>
		<td>
			<?php if($deputado['Deputado']['status_twitter']): echo "Tuitado"; endif; ?>
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