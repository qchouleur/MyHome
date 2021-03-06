USE [master]
GO
CREATE LOGIN [home_user] WITH PASSWORD=N'homeuser', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [home_user]
GO

USE [MyHome2013]
GO
CREATE USER [home_user] FOR LOGIN [home_user]
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Accounting')
BEGIN 
	EXEC ('CREATE SCHEMA [Accounting] AUTHORIZATION [dbo]')
END
GO

ALTER USER [home_user] WITH DEFAULT_SCHEMA=[Accounting]
GO
ALTER ROLE [db_owner] ADD MEMBER [home_user]
GO
