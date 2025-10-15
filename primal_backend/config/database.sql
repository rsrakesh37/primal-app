-- Create database
CREATE DATABASE IF NOT EXISTS primal_balance;
USE primal_balance;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Balance records table
CREATE TABLE IF NOT EXISTS balance_records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    description TEXT,
    type ENUM('income', 'expense') NOT NULL,
    category VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- User sessions table (for JWT token management)
CREATE TABLE IF NOT EXISTS user_sessions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    token_hash VARCHAR(255) NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Insert sample data
INSERT INTO users (email, password_hash, first_name, last_name) VALUES 
('demo@primal-balance.co.uk', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Demo', 'User');

INSERT INTO balance_records (user_id, amount, description, type, category) VALUES 
(1, 1000.00, 'Initial balance', 'income', 'salary'),
(1, -50.00, 'Grocery shopping', 'expense', 'food'),
(1, -25.00, 'Coffee', 'expense', 'food'),
(1, 500.00, 'Freelance work', 'income', 'freelance');