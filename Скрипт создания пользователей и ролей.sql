-- 1. Создание логинов для входа в SQL Server
CREATE LOGIN [логин_архивариус] WITH PASSWORD = 'СложныйПароль123!';
CREATE LOGIN [логин_специалист] WITH PASSWORD = 'СложныйПароль123!';
CREATE LOGIN [логин_чтение] WITH PASSWORD = 'СложныйПароль123!';

-- 2. Создание базы данных
 CREATE DATABASE ArchiveDB;
 USE ArchiveDB;

-- 3. Создание таблицы архива
CREATE TABLE dbo.ДокументыАрхива
(
    ИдентификаторДокумента INT IDENTITY(1,1) PRIMARY KEY,   -- Уникальный номер документа
    НазваниеДокумента NVARCHAR(255) NOT NULL,               -- Название документа
    ТипДокумента NVARCHAR(100) NOT NULL,                    -- Тип документа (например, Отчёт, Договор)
    ДатаДокумента DATETIME NOT NULL,                         -- Дата документа
    Создатель NVARCHAR(100) NOT NULL,                        -- Кто добавил документ
    ДатаСоздания DATETIME DEFAULT GETDATE() NOT NULL,       -- Дата добавления в архив
    Содержимое VARBINARY(MAX) NULL,                          -- Файл документа в бинарном формате (опционально)
    РасширениеФайла NVARCHAR(10) NULL                        -- Расширение файла (.pdf, .docx и т.п.)
);

-- 4. Создание пользователей базы данных, связанных с логинами
CREATE USER [пользователь_архивариус] FOR LOGIN [логин_архивариус];
CREATE USER [пользователь_специалист] FOR LOGIN [логин_специалист];
CREATE USER [пользователь_чтение] FOR LOGIN [логин_чтение];

-- 5. Создание ролей безопасности
CREATE ROLE [Архивариус];
CREATE ROLE [Специалист отдела];
CREATE ROLE [Чтение];

-- 6. Назначение прав ролям на таблицу архива
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.ДокументыАрхива TO [Архивариус];
GRANT SELECT, INSERT ON dbo.ДокументыАрхива TO [Специалист отдела];
GRANT SELECT ON dbo.ДокументыАрхива TO [Чтение];

-- 7. Запрет нежелательных операций для ролей с ограниченными правами
DENY DELETE, UPDATE ON dbo.ДокументыАрхива TO [Специалист отдела];
DENY DELETE, INSERT, UPDATE ON dbo.ДокументыАрхива TO [Чтение];

-- 8. Добавление пользователей в роли
EXEC sp_addrolemember 'Архивариус', 'пользователь_архивариус';
EXEC sp_addrolemember 'Специалист отдела', 'пользователь_специалист';
EXEC sp_addrolemember 'Чтение', 'пользователь_чтение';
