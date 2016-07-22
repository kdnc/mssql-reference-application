-- TRY CATCH

-- Goes to the catch block
BEGIN TRY
  select 1/0
END TRY
BEGIN CATCH
   SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() as ErrorState,
        ERROR_PROCEDURE() as ErrorProcedure,
        ERROR_LINE() as ErrorLine,
        ERROR_MESSAGE() as ErrorMessage;
END CATCH

-- Does not go to the catch block when sql statement is inside try block
BEGIN TRY
  select * from tblnonexistenttable
END TRY
BEGIN CATCH
   SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() as ErrorState,
        ERROR_PROCEDURE() as ErrorProcedure,
        ERROR_LINE() as ErrorLine,
        ERROR_MESSAGE() as ErrorMessage;
END CATCH

create proc spTest
as select * from tblnonexistenttable

-- Does go to the catch block when stored procedure is called inside try block
BEGIN TRY
  exec spTest
END TRY
BEGIN CATCH
   SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() as ErrorState,
        ERROR_PROCEDURE() as ErrorProcedure,
        ERROR_LINE() as ErrorLine,
        ERROR_MESSAGE() as ErrorMessage;
END CATCH

-- Call stored procedure with wrong type of input
-- Does go to the catch block
BEGIN TRY
  exec spReturnValue 'someText'
END TRY
BEGIN CATCH
   SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() as ErrorState,
        ERROR_PROCEDURE() as ErrorProcedure,
        ERROR_LINE() as ErrorLine,
        ERROR_MESSAGE() as ErrorMessage;
END CATCH