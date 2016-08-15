-- Optimize the following query by adding an index to studentId in CourseEnrollments table.

	-- Print some IO and time statistics in Messages tab when running the statement
		SET STATISTICS IO ON
		SET STATISTICS TIME ON

	-- The query to optimize
		select c.DepartmentCode, c.CourseNumber, c.CourseTitle, c.Credits, cd.Grade
			from CourseEnrollments cd
			inner join CourseOfferings co
				on cd.CourseOfferingId = co.CourseOfferingId
			inner join courses c
				on co.DepartmentCode = c.DepartmentCode
				AND co.CourseNumber = c.CourseNumber
			where cd.StudentId = 29717

	-- Running the Execution plan on above statement, suggests to add the studentId index as below

		/*
		Missing Index Details from 013 - Improving Statement Performance by Adding an Index.sql - (local)\SQLEXPRESS.Students (sa (52))
		The Query Processor estimates that implementing the following index could improve the query cost by 98.8914%.
		*/

		/*
		USE [Students]
		GO
		CREATE NONCLUSTERED INDEX IX_CourseEnrollments_studentId
		ON [dbo].[CourseEnrollments] ([StudentId])

		GO	
		*/		