<?php
require_once 'config/database.php';
require_once 'controllers/AuthController.php';

class UserController {
    private $db;

    public function __construct() {
        global $db;
        $this->db = $db;
    }

    private function authenticateUser() {
        $headers = getallheaders();
        $token = null;

        if (isset($headers['Authorization'])) {
            $authHeader = $headers['Authorization'];
            if (preg_match('/Bearer\s+(.*)$/i', $authHeader, $matches)) {
                $token = $matches[1];
            }
        }

        if (!$token) {
            http_response_code(401);
            echo json_encode(['error' => 'Authorization token required']);
            return false;
        }

        $payload = AuthController::validateJWT($token);
        if (!$payload) {
            http_response_code(401);
            echo json_encode(['error' => 'Invalid or expired token']);
            return false;
        }

        return $payload;
    }

    public function getProfile() {
        $user = $this->authenticateUser();
        if (!$user) return;

        try {
            $stmt = $this->db->prepare("SELECT id, email, first_name, last_name, phone, created_at FROM users WHERE id = ?");
            $stmt->execute([$user['user_id']]);
            $profile = $stmt->fetch();

            if (!$profile) {
                http_response_code(404);
                echo json_encode(['error' => 'User not found']);
                return;
            }

            echo json_encode([
                'user' => $profile
            ]);

        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode(['error' => 'Failed to fetch profile', 'message' => $e->getMessage()]);
        }
    }

    public function updateProfile() {
        $user = $this->authenticateUser();
        if (!$user) return;

        $input = json_decode(file_get_contents('php://input'), true);

        try {
            $updates = [];
            $params = [];

            if (isset($input['first_name'])) {
                $updates[] = "first_name = ?";
                $params[] = $input['first_name'];
            }

            if (isset($input['last_name'])) {
                $updates[] = "last_name = ?";
                $params[] = $input['last_name'];
            }

            if (isset($input['phone'])) {
                $updates[] = "phone = ?";
                $params[] = $input['phone'];
            }

            if (isset($input['email'])) {
                $email = filter_var($input['email'], FILTER_SANITIZE_EMAIL);
                if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                    http_response_code(400);
                    echo json_encode(['error' => 'Invalid email format']);
                    return;
                }

                // Check if email is already taken by another user
                $stmt = $this->db->prepare("SELECT id FROM users WHERE email = ? AND id != ?");
                $stmt->execute([$email, $user['user_id']]);
                if ($stmt->fetch()) {
                    http_response_code(409);
                    echo json_encode(['error' => 'Email already taken']);
                    return;
                }

                $updates[] = "email = ?";
                $params[] = $email;
            }

            if (empty($updates)) {
                http_response_code(400);
                echo json_encode(['error' => 'No valid fields to update']);
                return;
            }

            $params[] = $user['user_id'];
            $sql = "UPDATE users SET " . implode(', ', $updates) . " WHERE id = ?";
            $stmt = $this->db->prepare($sql);
            $stmt->execute($params);

            // Fetch updated profile
            $stmt = $this->db->prepare("SELECT id, email, first_name, last_name, phone FROM users WHERE id = ?");
            $stmt->execute([$user['user_id']]);
            $profile = $stmt->fetch();

            echo json_encode([
                'message' => 'Profile updated successfully',
                'user' => $profile
            ]);

        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode(['error' => 'Failed to update profile', 'message' => $e->getMessage()]);
        }
    }
}
?>