DROP DATABASE IF EXISTS gintleman_db;
CREATE DATABASE gintleman_db;
USE gintleman_db;

-- 1. TABELLA UTENTI
CREATE TABLE User (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, 
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    role ENUM('USER', 'ADMIN') DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. TABELLA PRODOTTI
CREATE TABLE Product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    image_url VARCHAR(255),
    category VARCHAR(50),
    alcohol_content DECIMAL(4, 1),
    nationality VARCHAR(50), 
    is_active BOOLEAN DEFAULT TRUE, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. TABELLA ORDINI
CREATE TABLE Orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status ENUM('PENDING', 'COMPLETED', 'CANCELED') DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(id)
);

-- 4. TABELLA DETTAGLI ORDINE
CREATE TABLE OrderItem (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price_at_purchase DECIMAL(10, 2) NOT NULL, 
    FOREIGN KEY (order_id) REFERENCES Orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(id) 
);

ALTER TABLE Orders ADD COLUMN address VARCHAR(255);
ALTER TABLE Orders ADD COLUMN city VARCHAR(100);
ALTER TABLE Orders ADD COLUMN zip_code VARCHAR(20);
ALTER TABLE Product ADD COLUMN subtitle VARCHAR(255);

-- DATI DI ESEMPIO (Per testare subito)
INSERT INTO User (email, password, first_name, last_name, role) VALUES 
('admin@gintleman.com', 'admin123', 'Admin', 'User', 'ADMIN'),
('user@test.com', 'user123', 'Mario', 'Rossi', 'USER');

INSERT INTO Product (name, subtitle, description, price, stock, nationality, is_active, image_url) VALUES
('Bombay Sapphire', 'L''originale', 'Gin classico dal gusto equilibrato.', 25.00, 100, 'UK', TRUE, 'img/prodotto_bombay.png'),
('Hendricks', 'Original', 'Gin scozzese al cetriolo e rosa.', 35.00, 50, 'Scotland', TRUE, 'img/prodotto_hendrick''s.png'), 
('Malfy Gin', 'Limone', 'Gin italiano al limone della costiera.', 30.00, 80, 'Italy', TRUE, 'img/prodotto_malfy.png'),
('Gin Mare', 'Mediterraneo','Gin mediterraneo con olive, timo, rosmarino e basilico.', 38.00, 60, 'Spain', TRUE, 'img/prodotto_gin_mare.png'),
('Monkey 47', 'Schwarzwald', 'Gin della Foresta Nera con 47 botaniche.', 45.00, 40, 'Germany', TRUE, 'img/prodotto_monkey.png'),
('Roku Gin', 'Japanese Craft', 'Gin giapponese artigianale.', 32.00, 45, 'Japan', TRUE, 'img/prodotto_roku.png'),
('Bombay Sapphire', 'Original', 'Gin con la distillazione originale di casa Bombay', 32.00, 45, 'UK', TRUE, 'img/prodotto_bombay_original.png'),
('Bombay Sapphire', 'Premier cru', 'Gin al limone di casa Bombay', 32.00, 45, 'UK', TRUE, 'img/prodotto_bombay_premier_cru.png'),
('Bombay Sapphire', 'Sunset', 'Gin con sentori di arancia di casa Bombay', 32.00, 45, 'UK', TRUE, 'img/prodotto_bombay_sunset.png'),
('Bombay Sapphire', 'Citron Presse', 'Gin con infusi al esclusivamente al limone', 32.00, 45, 'UK', TRUE, 'img/prodotto_citron_presse.png'),
('Gin Mare', 'Capri', 'Gin premium della linea Mare', 32.00, 45, 'Spain', TRUE, 'img/prodotto_gin_mare_capri.png'),
('Malfy Gin', 'Pompelmo', 'Il gin dominante quando si parla di pompelmo', 32.00, 45, 'Italy', TRUE, 'img/prodotto_malfy_lemon.png'),
('Malfy Gin', 'Limone', 'Gin al limone di casa Malfy', 32.00, 45, 'Italy', TRUE, 'img/prodotto_malfy_orange.png'),
('Malfy Gin', 'Arancia', 'Gin all''arancia di casa Malfy', 32.00, 45, 'Italy', TRUE, 'img/prodotto_malfy_rosa.png');
