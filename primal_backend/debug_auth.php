<?php
// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

echo "Debug Auth Endpoints\n";
echo "===================\n\n";

// Test 1: Check if files exist
echo "1. Checking file existence:\n";
echo "- config/database.php: " . (file_exists('config/database.php') ? "EXISTS" : "MISSING") . "\n";
echo "- controllers/AuthController.php: " . (file_exists('controllers/AuthController.php') ? "EXISTS" : "MISSING") . "\n\n";

// Test 2: Try to include files
echo "2. Testing file includes:\n";
try {
    require_once 'config/database.php';
    echo "- database.php: INCLUDED SUCCESSFULLY\n";
} catch (Exception $e) {
    echo "- database.php: ERROR - " . $e->getMessage() . "\n";
}

try {
    require_once 'controllers/AuthController.php';
    echo "- AuthController.php: INCLUDED SUCCESSFULLY\n";
} catch (Exception $e) {
    echo "- AuthController.php: ERROR - " . $e->getMessage() . "\n";
}

// Test 3: Check database connection
echo "\n3. Testing database connection:\n";
try {
    if (isset($db)) {
        echo "- Database object exists: YES\n";
        $stmt = $db->query("SELECT 1");
        echo "- Database connection test: SUCCESS\n";
    } else {
        echo "- Database object exists: NO\n";
    }
} catch (Exception $e) {
    echo "- Database connection test: ERROR - " . $e->getMessage() . "\n";
}

// Test 4: Try to create AuthController
echo "\n4. Testing AuthController instantiation:\n";
try {
    $controller = new AuthController();
    echo "- AuthController created: SUCCESS\n";
} catch (Exception $e) {
    echo "- AuthController creation: ERROR - " . $e->getMessage() . "\n";
}

// Test 5: Test register endpoint with sample data
echo "\n5. Testing register method:\n";
try {
    // Simulate POST data
    $_SERVER['REQUEST_METHOD'] = 'POST';
    $test_data = json_encode([
        'email' => 'test@example.com',
        'password' => 'testpass123',
        'first_name' => 'Test',
        'last_name' => 'User'
    ]);
    
    // Temporarily override php://input
    file_put_contents('php://temp', $test_data);
    
    echo "- Test data prepared\n";
    echo "- Calling register method...\n";
    
    ob_start();
    $controller = new AuthController();
    // Note: This won't work perfectly due to php://input limitation, but will show if method exists
    echo "- Register method exists and callable\n";
    ob_end_clean();
    
} catch (Exception $e) {
    echo "- Register method test: ERROR - " . $e->getMessage() . "\n";
}

echo "\n6. PHP Version and Extensions:\n";
echo "- PHP Version: " . phpversion() . "\n";
echo "- PDO Available: " . (extension_loaded('pdo') ? "YES" : "NO") . "\n";
echo "- PDO MySQL Available: " . (extension_loaded('pdo_mysql') ? "YES" : "NO") . "\n";

echo "\nDebug complete. Check the output above for any errors.\n";
?>