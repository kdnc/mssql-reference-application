-- Rewriting the statement to improve the performance

	-- The non optimized query (Get all the course sections that no students are signed up for) 
	-- The issue here is SQL Server is looking up all the enrollments for each course when we really only need to know
	-- is if there is any student enrolled in a course
		select co.* 
			from CourseOfferings co
			left outer join CourseEnrollments ce
				on co.CourseOfferingId = ce.CourseOfferingId
			where co.TermCode = 'SP2016'
				and ce.CourseOfferingId is null;

	-- The optimized query (Get all the course sections that no students are signed up for) 
	-- SQL Server does not have to read the data for every student enrolled in the course, it's just looking
	-- to see if atleast 1 student in the course
		select co.* 
			from CourseOfferings co
			where not exists
			(
				select 1 
					from CourseEnrollments ce
					where ce.CourseOfferingId = co.CourseOfferingId
			)
			and co.TermCode = 'SP2016';