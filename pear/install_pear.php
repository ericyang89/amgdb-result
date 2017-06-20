<?php
$file = 'http://pear.php.net/go-pear.phar';
$file2 = './go-pear.phar';

$current = file_get_contents($file);

file_put_contents($file2, $current);