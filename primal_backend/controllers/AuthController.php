<?php
require_once 'config/database.php';

class AuthController {
    private $db;

    public function __construct() {
        global $db;
        $this->db = $db;
    }

    public function register() {
        $input = json_decode(file_get_contents('php://input'), true);
        
        if (!isset($input['email']) || !isset($input['password'])) {
            http_response_code(400);
            echo json_encode(['error' => 'Email and password are required']);
            return;
        }

        $email = filter_var($input['email'], FILTER_SANITIZE_EMAIL);
        $password = $input['password'];
        $first_name = $input['first_name'] ?? '';
        $last_name = $input['last_name'] ?? '';
        $phone = $input['phone'] ?? '';

        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            http_response_code(400);
            echo json_encode(['error' => 'Invalid email format']);
            return;
        }

        if (strlen($password) < 6) {
            http_response_code(400);
            echo json_encode(['error' => 'Password must be at least 6 characters']);
            return;
        }

        try {
            // Check if user already exists
            $stmt = $this->db->prepare("SELECT id FROM users WHERE email = ?");
            $stmt->execute([$email]);
            
            if ($stmt->fetch()) {
                http_response_code(409);
                echo json_encode(['error' => 'User already exists']);
                return;
            }

            // Create new user
            $password_hash = password_hash($password, PASSWORD_DEFAULT);
            $stmt = $this->db->prepare("INSERT INTO users (email, password_hash, first_name, last_name, phone) VALUES (?, ?, ?, ?, ?)");
            $stmt->execute([$email, $password_hash, $first_name, $last_name, $phone]);

            $user_id = $this->db->lastInsertId();
            $token = $this->generateJWT($user_id, $email);

            echo json_encode([
                'message' => 'User registered successfully',
                'user' => [
                    'id' => $user_id,
                    'email' => $email,
                    'first_name' => $first_name,
                    'last_name' => $last_name
                ],
                'token' => $token
            ]);

        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode(['error' => 'Registration failed', 'message' => $e->getMessage()]);
        }
    }

    public function login() {
        $input = json_decode(file_get_contents('php://input'), true);
        
        if (!isset($input['email']) || !isset($input['password'])) {
            http_response_code(400);
            echo json_encode(['error' => 'Email and password are required']);
            return;
        }

        $email = filter_var($input['email'], FILTER_SANITIZE_EMAIL);
        $password = $input['password'];

        try {
            $stmt = $this->db->prepare("SELECT id, email, password_hash, first_name, last_name FROM users WHERE email = ?");
            $stmt->execute([$email]);
            $user = $stmt->fetch();

            if (!$user || !password_verify($password, $user['password_hash'])) {
                http_response_code(401);
                echo json_encode(['error' => 'Invalid credentials']);
                return;
            }

            $token = $this->generateJWT($user['id'], $user['email']);

            echo json_encode([
                'message' => 'Login successful',
                'user' => [
                    'id' => $user['id'],
                    'email' => $user['email'],
                    'first_name' => $user['first_name'],
                    'last_name' => $user['last_name']
                ],
                'token' => $token
            ]);

        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode(['error' => 'Login failed', 'message' => $e->getMessage()]);
        }
    }

    private function generateJWT($user_id, $email) {
        $header = json_encode(['typ' => 'JWT', 'alg' => 'HS256']);
        $payload = json_encode([
            'user_id' => $user_id,
            'email' => $email,
            'exp' => time() + (24 * 60 * 60) // 24 hours
        ]);

        $base64Header = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($header));
        $base64Payload = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($payload));

        $signature = hash_hmac('sha256', $base64Header . "." . $base64Payload, 'your-secret-key', true);
        $base64Signature = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($signature));

        return $base64Header . "." . $base64Payload . "." . $base64Signature;
    }

    public static function validateJWT($token) {
        $parts = explode('.', $token);
        if (count($parts) !== 3) {
            return false;
        }

        $header = base64_decode(str_replace(['-', '_'], ['+', '/'], $parts[0]));
        $payload = base64_decode(str_replace(['-', '_'], ['+', '/'], $parts[1]));
        $signature = $parts[2];

        $expectedSignature = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode(
            hash_hmac('sha256', $parts[0] . "." . $parts[1], 'your-secret-key', true)
        ));

        if ($signature !== $expectedSignature) {
            return false;
        }

        $payloadData = json_decode($payload, true);
        if ($payloadData['exp'] < time()) {
            return false;
        }

        return $payloadData;
    }
}
?>