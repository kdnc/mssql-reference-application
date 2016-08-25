BEGIN TRY
	BEGIN TRANSACTION 
		INSERT INTO dbo.ContactVerificationDetails(ContactId, DrivingLicenseNumber, ContactVerified) 
			VALUES (@ContactId, 1033, 1);
	COMMIT TRANSACTION;
	PRINT 'Transaction committed successfully.';
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION;
	PRINT 'Transaction rolled back. No changes made.';
END CATCH
