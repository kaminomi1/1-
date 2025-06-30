CREATE TRIGGER trg_AfterInsertUser
ON dbo.users
AFTER INSERT
AS
BEGIN
    DECLARE @Email NVARCHAR(255)
    DECLARE @BaseLogin NVARCHAR(100)
    DECLARE @NewLogin NVARCHAR(100)
    DECLARE @Counter INT = 1

    -- �������� email ������ ��� ������������ ������������
    SELECT @Email = email FROM INSERTED

    -- ��������� ������� �����
    SET @BaseLogin = LEFT(@Email, CHARINDEX('@', @Email) - 1)

    -- ���������, ���������� �� ��� ����� ����� � �������
    WHILE EXISTS (SELECT 1 FROM dbo.users WHERE login = @BaseLogin)
    BEGIN
        -- ���� ����� ����������, ��������� �������
        SET @BaseLogin = LEFT(@Email, CHARINDEX('@', @Email) - 1) + CAST(@Counter AS NVARCHAR)
        SET @Counter = @Counter + 1
    END

    -- ��������� ������ � ����� ���������� �������
    UPDATE dbo.users
    SET login = @BaseLogin
    FROM dbo.users u
    INNER JOIN INSERTED i ON u.user_id = i.user_id
END
GO
