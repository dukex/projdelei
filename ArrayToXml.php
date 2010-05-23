<?php
class ArrayToXml
{
	/**
	 * The main function for converting to an XML document.
	 * Pass in a multi dimensional array and this recrusively loops through and builds up an XML document.
	 *
	 * @param array $data
	 * @param string $rootNodeName - what you want the root node to be - defaultsto data.
	 * @param SimpleXMLElement $xml - should only be used recursively
	 * @return string XML
	 */
	public static function toXml($data, $root = 'data', $xml=null)
	{
		if (ini_get('zend.ze1_compatibility_mode') == 1):
			ini_set ('zend.ze1_compatibility_mode', 0);
		endif;
		
		if ($xml == null):
			$xml = simplexml_load_string("<?xml version='1.0' encoding='utf-8'?><{$root} />");
		endif;
		
		foreach($data as $key => $value):
			if (is_numeric($key)):
				$key = "_". (string) $key;
			endif;
			if (is_array($value)):
				$node = $xml->addChild($key);
				ArrayToXML::toXml($value, $root, $node);
			else:
				$xml->addChild($key,$value);
			endif;
		endforeach;
		return $xml->asXML();
	}
}
?>