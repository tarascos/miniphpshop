<?php

ini_set('display_errors', 'On');
error_reporting(E_ALL);

/*
 * 1. /var/www/miniphpshop/source/
 * 2. /var/www/miniphpshop/source
 */
define('MPS_ROOT', rtrim($_SERVER['DOCUMENT_ROOT'], '/\\') . '/');

function mps_dump($data)
{
    echo '<pre>';
    print_r($data);
    echo '</pre>';
}

function mps_notfound()
{
    header("HTTP/1.0 404 Not Found");
    echo "404 Not Found";
    exit;
}


$config = require MPS_ROOT . 'etc/config.php';
$uri    = isset($_SERVER['REQUEST_URI']) ? $_SERVER['REQUEST_URI'] : '';
$uri    = trim($uri, '/');


$uriParts = strlen($uri) == 0 ? array() : explode('/', $uri);
$path     = array('args' => array());
$count    = count($uriParts);


if ($count == 0) {
    $path['controller'] = $config['router']['default_controller'];
    $path['action']     = $config['router']['default_action'];
} elseif ($count == 1) {
    $path['controller'] = $uriParts[0];
    $path['action']     = $config['router']['default_action'];
} else {
    $path['controller'] = array_shift($uriParts);
    $path['action']     = array_shift($uriParts);
    $path['args']       = $uriParts;
}



$path['controller'] = strtolower($path['controller']);
$path['action']     = strtolower($path['action']);


$filename = MPS_ROOT . 'controller/' . $path['controller'] . '.php';
if (!file_exists($filename)) {
    mps_notfound();
}

require $filename;

$classname  = 'Controller_' . ucfirst($path['controller']);
$controller = new $classname();

if (!method_exists($controller, $path['action'])) {
    mps_notfound();
}

ob_start();

call_user_func_array(array($controller, $path['action']), $path['args']);

ob_end_flush();
