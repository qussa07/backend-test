-- ============================================================
-- Схема БД для приложения учёта заявок технической поддержки
-- MySQL 8.0 | UTF-8 (utf8mb4)
-- ============================================================

CREATE TABLE IF NOT EXISTS tickets (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title       VARCHAR(255)                            NOT NULL,
    description TEXT,
    priority    ENUM('low', 'medium', 'high')           NOT NULL DEFAULT 'medium',
    status      ENUM('open', 'in_progress', 'closed')   NOT NULL DEFAULT 'open',
    created_at  TIMESTAMP                               NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP                               NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_status   (status),
    INDEX idx_priority (priority)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS ticket_attachments (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ticket_id   INT UNSIGNED                            NOT NULL,
    filepath    VARCHAR(255)                            NOT NULL,
    size        INT UNSIGNED                            NOT NULL,
    uploaded_at TIMESTAMP                               NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_attachments_ticket
        FOREIGN KEY (ticket_id) REFERENCES tickets(id) ON DELETE CASCADE,

    INDEX idx_ticket_id (ticket_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
