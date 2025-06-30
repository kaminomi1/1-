CREATE TRIGGER trg_AfterInsertUser
ON dbo.users
AFTER INSERT
AS
BEGIN
    DECLARE @Email NVARCHAR(255)
    DECLARE @BaseLogin NVARCHAR(100)
    DECLARE @NewLogin NVARCHAR(100)
    DECLARE @Counter INT = 1

    -- Получаем email только что вставленного пользователя
    SELECT @Email = email FROM INSERTED

    -- Формируем базовый логин
    SET @BaseLogin = LEFT(@Email, CHARINDEX('@', @Email) - 1)

    -- Проверяем, существует ли уже такой логин в системе
    WHILE EXISTS (SELECT 1 FROM dbo.users WHERE login = @BaseLogin)
    BEGIN
        -- Если логин существует, добавляем счетчик
        SET @BaseLogin = LEFT(@Email, CHARINDEX('@', @Email) - 1) + CAST(@Counter AS NVARCHAR)
        SET @Counter = @Counter + 1
    END

    -- Обновляем запись с новым уникальным логином
    UPDATE dbo.users
    SET login = @BaseLogin
    FROM dbo.users u
    INNER JOIN INSERTED i ON u.user_id = i.user_id
END
GO
