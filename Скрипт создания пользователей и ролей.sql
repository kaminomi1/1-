-- 1. �������� ������� ��� ����� � SQL Server
CREATE LOGIN [�����_����������] WITH PASSWORD = '�������������123!';
CREATE LOGIN [�����_����������] WITH PASSWORD = '�������������123!';
CREATE LOGIN [�����_������] WITH PASSWORD = '�������������123!';

-- 2. �������� ���� ������
 CREATE DATABASE ArchiveDB;
 USE ArchiveDB;

-- 3. �������� ������� ������
CREATE TABLE dbo.���������������
(
    ���������������������� INT IDENTITY(1,1) PRIMARY KEY,   -- ���������� ����� ���������
    ����������������� NVARCHAR(255) NOT NULL,               -- �������� ���������
    ������������ NVARCHAR(100) NOT NULL,                    -- ��� ��������� (��������, �����, �������)
    ������������� DATETIME NOT NULL,                         -- ���� ���������
    ��������� NVARCHAR(100) NOT NULL,                        -- ��� ������� ��������
    ������������ DATETIME DEFAULT GETDATE() NOT NULL,       -- ���� ���������� � �����
    ���������� VARBINARY(MAX) NULL,                          -- ���� ��������� � �������� ������� (�����������)
    ��������������� NVARCHAR(10) NULL                        -- ���������� ����� (.pdf, .docx � �.�.)
);

-- 4. �������� ������������� ���� ������, ��������� � ��������
CREATE USER [������������_����������] FOR LOGIN [�����_����������];
CREATE USER [������������_����������] FOR LOGIN [�����_����������];
CREATE USER [������������_������] FOR LOGIN [�����_������];

-- 5. �������� ����� ������������
CREATE ROLE [����������];
CREATE ROLE [���������� ������];
CREATE ROLE [������];

-- 6. ���������� ���� ����� �� ������� ������
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.��������������� TO [����������];
GRANT SELECT, INSERT ON dbo.��������������� TO [���������� ������];
GRANT SELECT ON dbo.��������������� TO [������];

-- 7. ������ ������������� �������� ��� ����� � ������������� �������
DENY DELETE, UPDATE ON dbo.��������������� TO [���������� ������];
DENY DELETE, INSERT, UPDATE ON dbo.��������������� TO [������];

-- 8. ���������� ������������� � ����
EXEC sp_addrolemember '����������', '������������_����������';
EXEC sp_addrolemember '���������� ������', '������������_����������';
EXEC sp_addrolemember '������', '������������_������';
