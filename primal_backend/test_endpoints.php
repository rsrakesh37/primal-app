<?php
// Test script to verify API endpoints
echo "Testing API Endpoints\n";
echo "====================\n\n";

// Test 1: Health endpoint
echo "1. Testing /api/health\n";
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, 'http://localhost/primal_backend/api/health');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

echo "Status: $httpCode\n";
echo "Response: $response\n\n";

// Test 2: Register endpoint
echo "2. Testing /api/auth/register\n";
$registerData = json_encode([
    'email' => 'test@example.com',
    'password' => 'testpass123',
    'first_name' => 'Test',
    'last_name' => 'User'
]);

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, 'http://localhost/primal_backend/api/auth/register');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, $registerData);
curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

echo "Status: $httpCode\n";
echo "Response: $response\n\n";

// Extract token for further tests
$registerResponse = json_decode($response, true);
$token = $registerResponse['token'] ?? null;

// Test 3: Login endpoint
echo "3. Testing /api/auth/login\n";
$loginData = json_encode([
    'email' => 'test@example.com',
    'password' => 'testpass123'
]);

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, 'http://localhost/primal_backend/api/auth/login');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, $loginData);
curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

echo "Status: $httpCode\n";
echo "Response: $response\n\n";

// Use token from login if register didn't provide one
if (!$token) {
    $loginResponse = json_decode($response, true);
    $token = $loginResponse['token'] ?? null;
}

// Test 4: Balance endpoint (requires authentication)
echo "4. Testing /api/balance (GET)\n";
if ($token) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, 'http://localhost/primal_backend/api/balance');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Content-Type: application/json',
        'Authorization: Bearer ' . $token
    ]);
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    echo "Status: $httpCode\n";
    echo "Response: $response\n\n";
} else {
    echo "No token available - skipping authenticated endpoints\n\n";
}

echo "Endpoint testing complete!\n";
?>