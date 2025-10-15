<?php
// Production database configuration for shared hosting
$host = 'localhost';
$dbname = 'rectubmx_primal_app';
$username = 'rectubmx_primal_user';
$password = 'Inferno@8087';

// Try PDO first (for shared hosting), fallback to MySQLi (for local development)
$db = null;
$use_pdo = false;

if (extension_loaded('pdo_mysql')) {
    try {
        $db = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
        ]);
        $use_pdo = true;
    } catch (PDOException $e) {
        // PDO failed, will try MySQLi below
        $db = null;
    }
}

if (!$db && extension_loaded('mysqli')) {
    try {
        $db = new mysqli($host, $username, $password, $dbname);
        if ($db->connect_error) {
            throw new Exception("MySQLi connection failed: " . $db->connect_error);
        }
        $db->set_charset("utf8mb4");
        $use_pdo = false;
    } catch (Exception $e) {
        // For local development, create a mock database connection
        $db = new stdClass();
        $db->mock = true;
        $use_pdo = false;
    }
}

if (!$db) {
    // Create a mock database for local development when no database is available
    $db = new stdClass();
    $db->mock = true;
    $use_pdo = false;
}

function getConnection() {
    global $db;
    return $db;
}

function isPDO() {
    global $use_pdo;
    return $use_pdo;
}

function isMock() {
    global $db;
    return isset($db->mock) && $db->mock;
}
?>