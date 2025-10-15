<?php
// Test MySQLi database connection for shared hosting
require_once 'config/database_mysqli.php';

echo "=== Shared Hosting Database Test ===\n";
echo "Database: rectubmx_primal_app\n";
echo "Username: rectubmx_primal_user\n";
echo "Host: localhost\n\n";

try {
    $database = new DatabaseMySQLi();
    $connection = $database->getConnection();
    
    if ($connection) {
        echo "✅ MySQLi Database connection successful!\n";
        
        // Test a simple query
        $result = $connection->query("SELECT 1 as test");
        if ($result && $row = $result->fetch_assoc()) {
            if ($row['test'] == 1) {
                echo "✅ Database query test successful!\n";
            }
        }
        
        // Show database info
        $result = $connection->query("SELECT DATABASE() as current_db, USER() as current_user");
        if ($result && $info = $result->fetch_assoc()) {
            echo "\nConnection Info:\n";
            echo "Current Database: " . $info['current_db'] . "\n";
            echo "Current User: " . $info['current_user'] . "\n";
        }
        
        // Show tables if any exist
        $result = $connection->query("SHOW TABLES");
        if ($result) {
            echo "\nTables in database:\n";
            if ($result->num_rows > 0) {
                while ($row = $result->fetch_array()) {
                    echo "- " . $row[0] . "\n";
                }
            } else {
                echo "No tables found (database is empty)\n";
            }
        }
        
        $database->close();
        
    } else {
        echo "❌ Database connection failed!\n";
    }
    
} catch (Exception $e) {
    echo "❌ Connection Error: " . $e->getMessage() . "\n";
    echo "\nTroubleshooting for Shared Hosting:\n";
    echo "1. Check if database name is correct\n";
    echo "2. Verify username and password\n";
    echo "3. Ensure database user has proper permissions\n";
    echo "4. Check if MySQL service is running\n";
    echo "5. Contact hosting provider if issues persist\n";
}
?>