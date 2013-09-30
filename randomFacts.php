<?php
$lines = file(getcwd() . "/randomFacts.txt");
echo $lines[array_rand($lines)];
?>
