<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <?php echo $this->Html->charset(); ?>
    <title><?php echo $title_for_layout; ?></title>
	<?php
		//echo $this->Html->meta('icon');
		echo $this->Html->css('reset');
		echo $this->Html->css('text');
		echo $this->Html->css('typogridphy');
		echo $this->Html->css('960');
		echo $this->Html->css('application');
		echo $this->Html->css('table');
		echo $scripts_for_layout;
	?>
</head>
<body>
    <?php echo $this->Session->flash(); ?>
	<?php echo $content_for_layout; ?>
</body>
</html>