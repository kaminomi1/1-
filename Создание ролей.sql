USE СервисЦентрРемонта;
GO

-- 1. Создаем логины на уровне сервера (SQL Server аутентификация)
CREATE LOGIN [admin_login] WITH PASSWORD = 'SPas1';
CREATE LOGIN [master_login] WITH PASSWORD = 'SPas2';
CREATE LOGIN [client_login] WITH PASSWORD = 'SPas3';
CREATE LOGIN [operator_login] WITH PASSWORD = 'SPas4';

-- Создание ролей
CREATE ROLE Администратор;
CREATE ROLE Мастер;
CREATE ROLE Клиент;
CREATE ROLE Оператор;
GO
-- Добавление пользователей базы данных (пример, предполагается что логины уже существуют)
-- Создадим пользователей (пример для демонстрации)

CREATE USER [admin_user] FOR LOGIN [admin_login];
CREATE USER [master_user] FOR LOGIN [master_login];
CREATE USER [client_user] FOR LOGIN [client_login];
CREATE USER [operator_user] FOR LOGIN [operator_login];
GO

-- Добавление пользователей в роли
EXEC sp_addrolemember 'Администратор', 'admin_user';
EXEC sp_addrolemember 'Мастер', 'master_user';
EXEC sp_addrolemember 'Клиент', 'client_user';
EXEC sp_addrolemember 'Оператор', 'operator_user';
GO

-- Назначение прав ролям

-- Администратор — полный доступ
GRANT SELECT, INSERT, UPDATE, DELETE ON Клиенты TO Администратор;
GRANT SELECT, INSERT, UPDATE, DELETE ON Мастера TO Администратор;
GRANT SELECT, INSERT, UPDATE, DELETE ON Техника TO Администратор;
GRANT SELECT, INSERT, UPDATE, DELETE ON Заявки TO Администратор;
GRANT SELECT, INSERT, UPDATE, DELETE ON Оплаты TO Администратор;
GRANT SELECT, INSERT, UPDATE, DELETE ON Статусы TO Администратор;

-- Мастер — чтение заявок и своих данных, обновление своих заявок
GRANT SELECT ON Клиенты TO Мастер;
GRANT SELECT, UPDATE ON Заявки TO Мастер;
GRANT SELECT ON Техника TO Мастер;
GRANT SELECT ON Статусы TO Мастер;

-- Клиент — чтение и создание своих заявок, чтение своих данных
GRANT SELECT ON Клиенты TO Клиент;
GRANT SELECT, INSERT ON Заявки TO Клиент;
GRANT SELECT ON Техника TO Клиент;
GRANT SELECT ON Оплаты TO Клиент;

-- Оператор — создание и чтение заявок, просмотр клиентов и техники
GRANT SELECT, INSERT ON Заявки TO Оператор;
GRANT SELECT ON Клиенты TO Оператор;
GRANT SELECT ON Техника TO Оператор;
GO
