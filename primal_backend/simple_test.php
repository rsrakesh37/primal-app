<?php
// Simple test script to verify API endpoints without cURL
echo "Testing API Endpoints (Direct)\n";
echo "===============================\n\n";

// Simulate the environment
$_SERVER['REQUEST_METHOD'] = 'POST';
$_SERVER['REQUEST_URI'] = '/primal_backend/api/auth/register';

// Test 1: Register endpoint
echo "1. Testing Register Endpoint\n";
try {
    // Include necessary files
    require_once 'config/database.php';
    require_once 'controllers/AuthController.php';
    
    // Create controller instance
    $authController = new AuthController();
    
    // Simulate POST data for registration
    $testInput = json_encode([
        'email' => 'test@example.com',
        'password' => 'testpass123',
        'first_name' => 'Test',
        'last_name' => 'User'
    ]);
    
    // Mock the input stream
    $temp = tmpfile();
    fwrite($temp, $testInput);
    rewind($temp);
    
    // Capture output
    ob_start();
    
    // Override file_get_contents for php://input
    function file_get_contents_override($filename) {
        global $testInput;
        if ($filename === 'php://input') {
            return $testInput;
        }
        return file_get_contents($filename);
    }
    
    // Test register method
    $authController->register();
    
    $output = ob_get_clean();
    echo "Register Response: $output\n\n";
    
    fclose($temp);
    
} catch (Exception $e) {
    echo "Register Error: " . $e->getMessage() . "\n\n";
}

// Test 2: Login endpoint
echo "2. Testing Login Endpoint\n";
try {
    // Create new controller instance
    $authController = new AuthController();
    
    // Simulate POST data for login
    $testInput = json_encode([
        'email' => 'test@example.com',
        'password' => 'testpass123'
    ]);
    
    // Capture output
    ob_start();
    
    // Test login method
    $authController->login();
    
    $output = ob_get_clean();
    echo "Login Response: $output\n\n";
    
} catch (Exception $e) {
    echo "Login Error: " . $e->getMessage() . "\n\n";
}

// Test 3: Database connection
echo "3. Testing Database Connection\n";
try {
    $db = getConnection();
    if ($db) {
        echo "Database connection: SUCCESS\n";
        if (isMock()) {
            echo "Using mock database for local development\n";
        } elseif (isPDO()) {
            echo "Using PDO connection\n";
        } else {
            echo "Using MySQLi connection\n";
        }
    } else {
        echo "Database connection: FAILED\n";
    }
} catch (Exception $e) {
    echo "Database Error: " . $e->getMessage() . "\n";
}

echo "\nTest complete!\n";
?>