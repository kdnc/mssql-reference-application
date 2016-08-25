-- Deadlock example

	-- Uses the WAITFOR statement to pause both transactions for ten seconds to simulate the deadlock.
	BEGIN TRANSACTION
		UPDATE works_on
			SET job = 'Manager'
			WHERE emp_no = 18316
			AND project_no = 'p2'
		WAITFOR DELAY '00:00:10'
		UPDATE employee
			SET emp_lname = 'Green'
			WHERE emp_no = 9031
	COMMIT

	BEGIN TRANSACTION
		UPDATE employee
			SET dept_no = 'd2'
			WHERE emp_no = 9031
		WAITFOR DELAY '00:00:10'
		DELETE FROM works_on
			WHERE emp_no = 18316
			AND project_no = 'p2'
	COMMIT