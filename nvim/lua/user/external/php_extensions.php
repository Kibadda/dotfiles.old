<?php

$extensions = get_loaded_extensions();

foreach ($extensions as $extension) {
    echo $extension . PHP_EOL;
}
