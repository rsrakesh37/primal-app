<?php
class DatabaseMySQLi {
    private $host;
    private $db_name;
    private $username;
    private $password;
    private $conn;

    public function __construct() {
        // Use environment variables or default values
        $this->host = $_ENV['DB_HOST'] ?? 'localhost';
        $this->db_name = $_ENV['DB_NAME'] ?? 'rectubmx_primal_app';
        $this->username = $_ENV['DB_USER'] ?? 'rectubmx_primal_user';
        $this->password = $_ENV['DB_PASS'] ?? 'Inferno@8087';
    }

    public function getConnection() {
        $this->conn = null;

        try {
            // Create MySQLi connection
            $this->conn = new mysqli(
                $this->host,
                $this->username,
                $this->password,
                $this->db_name
            );

            // Check connection
            if ($this->conn->connect_error) {
                throw new Exception("Connection failed: " . $this->conn->connect_error);
            }

            // Set charset
            $this->conn->set_charset("utf8");
            
        } catch(Exception $exception) {
            throw new Exception("Connection error: " . $exception->getMessage());
        }

        return $this->conn;
    }

    public function close() {
        if ($this->conn) {
            $this->conn->close();
        }
    }
}

// Global database instance using MySQLi
$database_mysqli = new DatabaseMySQLi();
$db_mysqli = $database_mysqli->getConnection();
?>