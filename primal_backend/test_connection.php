<?php
// Test database connection
require_once 'config/database.php';

try {
    echo "Testing database connection...\n";
    echo "Database: rectubmx_primal_app\n";
    echo "Username: rectubmx_primal_user\n";
    echo "Host: localhost\n\n";
    
    $database = new Database();
    $connection = $database->getConnection();
    
    if ($connection) {
        echo "✅ Database connection successful!\n";
        
        // Test a simple query
        $stmt = $connection->prepare("SELECT 1 as test");
        $stmt->execute();
        $result = $stmt->fetch();
        
        if ($result && $result['test'] == 1) {
            echo "✅ Database query test successful!\n";
        } else {
            echo "❌ Database query test failed!\n";
        }
        
        // Show database info
        $stmt = $connection->prepare("SELECT DATABASE() as current_db, USER() as current_user");
        $stmt->execute();
        $info = $stmt->fetch();
        
        echo "\nConnection Info:\n";
        echo "Current Database: " . $info['current_db'] . "\n";
        echo "Current User: " . $info['current_user'] . "\n";
        
    } else {
        echo "❌ Database connection failed!\n";
    }
    
} catch (Exception $e) {
    echo "❌ Connection Error: " . $e->getMessage() . "\n";
}
?>