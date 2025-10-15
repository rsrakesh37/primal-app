<?php
require_once 'config/database.php';
require_once 'controllers/AuthController.php';

class BalanceController {
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

    public function getBalance() {
        $user = $this->authenticateUser();
        if (!$user) return;

        try {
            // Calculate total balance
            $stmt = $this->db->prepare("
                SELECT 
                    SUM(CASE WHEN type = 'income' THEN amount ELSE -amount END) as total_balance,
                    SUM(CASE WHEN type = 'income' THEN amount ELSE 0 END) as total_income,
                    SUM(CASE WHEN type = 'expense' THEN amount ELSE 0 END) as total_expenses,
                    COUNT(*) as total_transactions
                FROM balance_records 
                WHERE user_id = ?
            ");
            $stmt->execute([$user['user_id']]);
            $balance = $stmt->fetch();

            // Get recent transactions
            $stmt = $this->db->prepare("
                SELECT id, amount, description, type, category, created_at 
                FROM balance_records 
                WHERE user_id = ? 
                ORDER BY created_at DESC 
                LIMIT 10
            ");
            $stmt->execute([$user['user_id']]);
            $recent_transactions = $stmt->fetchAll();

            echo json_encode([
                'balance' => [
                    'total' => floatval($balance['total_balance'] ?? 0),
                    'income' => floatval($balance['total_income'] ?? 0),
                    'expenses' => floatval($balance['total_expenses'] ?? 0),
                    'transactions_count' => intval($balance['total_transactions'] ?? 0)
                ],
                'recent_transactions' => $recent_transactions
            ]);

        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode(['error' => 'Failed to fetch balance', 'message' => $e->getMessage()]);
        }
    }

    public function updateBalance() {
        $user = $this->authenticateUser();
        if (!$user) return;

        $input = json_decode(file_get_contents('php://input'), true);

        if (!isset($input['amount']) || !isset($input['type'])) {
            http_response_code(400);
            echo json_encode(['error' => 'Amount and type are required']);
            return;
        }

        $amount = floatval($input['amount']);
        $type = $input['type'];
        $description = $input['description'] ?? '';
        $category = $input['category'] ?? '';

        if ($amount <= 0) {
            http_response_code(400);
            echo json_encode(['error' => 'Amount must be positive']);
            return;
        }

        if (!in_array($type, ['income', 'expense'])) {
            http_response_code(400);
            echo json_encode(['error' => 'Type must be either income or expense']);
            return;
        }

        try {
            $stmt = $this->db->prepare("
                INSERT INTO balance_records (user_id, amount, description, type, category) 
                VALUES (?, ?, ?, ?, ?)
            ");
            $stmt->execute([$user['user_id'], $amount, $description, $type, $category]);

            $record_id = $this->db->lastInsertId();

            // Get the new record
            $stmt = $this->db->prepare("
                SELECT id, amount, description, type, category, created_at 
                FROM balance_records 
                WHERE id = ?
            ");
            $stmt->execute([$record_id]);
            $new_record = $stmt->fetch();

            // Calculate updated balance
            $stmt = $this->db->prepare("
                SELECT SUM(CASE WHEN type = 'income' THEN amount ELSE -amount END) as total_balance
                FROM balance_records 
                WHERE user_id = ?
            ");
            $stmt->execute([$user['user_id']]);
            $balance = $stmt->fetch();

            echo json_encode([
                'message' => 'Balance updated successfully',
                'record' => $new_record,
                'new_balance' => floatval($balance['total_balance'] ?? 0)
            ]);

        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode(['error' => 'Failed to update balance', 'message' => $e->getMessage()]);
        }
    }

    public function getBalanceHistory() {
        $user = $this->authenticateUser();
        if (!$user) return;

        $page = intval($_GET['page'] ?? 1);
        $limit = intval($_GET['limit'] ?? 20);
        $type = $_GET['type'] ?? null;
        $category = $_GET['category'] ?? null;

        $offset = ($page - 1) * $limit;

        try {
            $where_conditions = ["user_id = ?"];
            $params = [$user['user_id']];

            if ($type && in_array($type, ['income', 'expense'])) {
                $where_conditions[] = "type = ?";
                $params[] = $type;
            }

            if ($category) {
                $where_conditions[] = "category = ?";
                $params[] = $category;
            }

            $where_clause = implode(' AND ', $where_conditions);

            // Get total count
            $stmt = $this->db->prepare("SELECT COUNT(*) as total FROM balance_records WHERE $where_clause");
            $stmt->execute($params);
            $total = $stmt->fetch()['total'];

            // Get records
            $stmt = $this->db->prepare("
                SELECT id, amount, description, type, category, created_at 
                FROM balance_records 
                WHERE $where_clause 
                ORDER BY created_at DESC 
                LIMIT ? OFFSET ?
            ");
            $params[] = $limit;
            $params[] = $offset;
            $stmt->execute($params);
            $records = $stmt->fetchAll();

            echo json_encode([
                'records' => $records,
                'pagination' => [
                    'page' => $page,
                    'limit' => $limit,
                    'total' => intval($total),
                    'pages' => ceil($total / $limit)
                ]
            ]);

        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode(['error' => 'Failed to fetch balance history', 'message' => $e->getMessage()]);
        }
    }
}
?>