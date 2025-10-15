<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Handle preflight OPTIONS requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once 'config/database.php';
require_once 'controllers/AuthController.php';
require_once 'controllers/UserController.php';
require_once 'controllers/BalanceController.php';

// Simple routing
$request_uri = $_SERVER['REQUEST_URI'];
$path = parse_url($request_uri, PHP_URL_PATH);
$method = $_SERVER['REQUEST_METHOD'];

// Remove base path if needed
$path = str_replace('/primal_backend', '', $path);

try {
    switch ($path) {
        case '/api/auth/register':
            if ($method === 'POST') {
                $controller = new AuthController();
                $controller->register();
            }
            break;
            
        case '/api/auth/login':
            if ($method === 'POST') {
                $controller = new AuthController();
                $controller->login();
            }
            break;
            
        case '/api/user/profile':
            if ($method === 'GET') {
                $controller = new UserController();
                $controller->getProfile();
            } elseif ($method === 'PUT') {
                $controller = new UserController();
                $controller->updateProfile();
            }
            break;
            
        case '/api/balance':
            if ($method === 'GET') {
                $controller = new BalanceController();
                $controller->getBalance();
            } elseif ($method === 'POST') {
                $controller = new BalanceController();
                $controller->updateBalance();
            }
            break;
            
        case '/api/balance/history':
            if ($method === 'GET') {
                $controller = new BalanceController();
                $controller->getBalanceHistory();
            }
            break;
            
        case '/api/health':
            echo json_encode(['status' => 'ok', 'timestamp' => date('Y-m-d H:i:s')]);
            break;
            
        default:
            http_response_code(404);
            echo json_encode(['error' => 'Endpoint not found']);
            break;
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Internal server error', 'message' => $e->getMessage()]);
}
?>