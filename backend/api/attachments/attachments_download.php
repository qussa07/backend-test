<?php

require __DIR__ . '/../../config/database.php';

$fileId = $segments[3];

$sql = "SELECT filepath FROM ticket_attachments WHERE id = ?";
$result = db()->execute_query($sql, [$fileId]);

if ($result) {
    $attachment = $result->fetch_assoc();
    if ($attachment) {
        $filePath = __DIR__ . "/../../uploads/" . $attachment['filepath'];
        if (file_exists($filePath)) {
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename="' . basename($filePath) . '"');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . filesize($filePath));
            readfile($filePath);
            exit;
        } else {
            respond(404, 'Файл не найден на сервере');
        }
    } else {
        respond(404, 'Вложение не найдено');
    }
} else {
    respond(500, 'Ошибка базы данных');
}