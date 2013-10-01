<?php
$file = getcwd() . "/randomFacts.txt";
$log = getcwd() . "/log.txt";
$date = new DateTime();
$lines = file($file);
$i = 0;

// Loop through each line of the file, removing any exact duplicates.
foreach ($lines as $key1 => & $value1) {
    foreach ($lines as $key2 => $value2) {
        if (($value1 == $value2) && ($key1 != $key2)) {
            $date = $date->setTimeStamp(time());
            file_put_contents($log, ("[" . $date->format("Y-m-d H:i:s") . "] Removing fact " . ($key2 + 1) . ". Same as fact " . ($key1 + 1) . ". "  . $value1), FILE_APPEND);
            unset($lines[$key2]);
            $i++;
        }
    }
}

if ($i > 0) {
    $date = $date->setTimeStamp(time());
    file_put_contents($log, ("[" . $date->format("Y-m-d H:i:s") . "] " . $i . " duplicate facts removed.\n"), FILE_APPEND);
    file_put_contents($file, $lines);
    $lines = file($file);
}

echo $lines[array_rand($lines)];
?>
