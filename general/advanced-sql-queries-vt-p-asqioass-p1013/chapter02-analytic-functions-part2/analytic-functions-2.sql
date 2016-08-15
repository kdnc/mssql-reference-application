USE [Children]

-- Prepare the database tables
	-- 1. Create table
	GO
	DROP TABLE [dbo].[CHILDSTAT]

	CREATE TABLE [dbo].[CHILDSTAT](
		[FIRSTNAME] [varchar](50) NULL,
		[GENDER] [char](2) NULL,
		[BIRTHDATE] [date] NULL,
		[HEIGHT] [int] NULL,
		[WEIGHT] [int] NULL
	) ON [PRIMARY]
	GO

	-- 2. Insert data into table
	GO
	INSERT INTO [dbo].[CHILDSTAT]
			   ([FIRSTNAME]
			   ,[GENDER]
			   ,[BIRTHDATE]
			   ,[HEIGHT]
			   ,[WEIGHT])
		 VALUES
			   ('LAUREN' ,'F', '10-JUN-00', 54, 876),
			   ('ROSEMARY' ,'F', '08-MAY-00', 35, 123),
			   ('ALBERT' ,'M', '02-AUG-00', 45, 150),
			   ('BUDDY' ,'M', '02-OCT-98', 45, 189),
			   ('FARQUAR' ,'M', '05-NOV-98', 76, 198),
			   ('SIMON' ,'M', '03-JAN-99', 87, 256),
			   ('TOMMY' ,'M', '11-DEC-98', 78, 167)

	GO

-- ROW_NUMBER() function
-- =====================

-- Task 1: Create a column containing row numbers ordered by ascending name
	-- Analytic Method
	GO

	SELECT A.*,
		ROW_NUMBER() OVER (ORDER BY A.FIRSTNAME) AS RNUM
	FROM CHILDSTAT A

	GO
	/*
	FIRSTNAME	GENDER	BIRTHDATE	HEIGHT	WEIGHT	RNUM
	ALBERT		M	 	2000-08-02	45		150		1
	BUDDY		M 		1998-10-02	45		189		2
	FARQUAR		M 		1998-11-05	76		198		3
	LAUREN		F 		2000-06-10	54		876		4
	ROSEMARY	F 		2000-05-08	35		123		5
	SIMON		M 		1999-01-03	87		256		6
	TOMMY		M 		1998-12-11	78		167		7
	*/

-- Task 2: Create a column containing row  numbers within gender
	-- Analytic Method
	GO

	SELECT A.*,
		ROW_NUMBER() OVER (PARTITION BY A.GENDER ORDER BY A.FIRSTNAME) AS RNUM
	FROM CHILDSTAT A
	ORDER BY A.GENDER, A.FIRSTNAME
	
	GO
	/*
	FIRSTNAME	GENDER	BIRTHDATE	HEIGHT	WEIGHT	RNUM
	LAUREN		F 		2000-06-10		54		876		1
	ROSEMARY	F 		2000-05-08		35		123		2
	ALBERT		M 		2000-08-02		45		150		1
	BUDDY		M 		1998-10-02		45		189		2
	FARQUAR		M 		1998-11-05		76		198		3
	SIMON		M 		1999-01-03		87		256		4
	TOMMY		M 		1998-12-11		78		167		5
	*/

-- LEAD()/ LAG() functions
-- =======================

-- Task 3: Create two additional columns using the weight
		 --1. the next previous height
		 --2. the previous lightest weight
	GO

	SELECT A.FIRSTNAME, A.WEIGHT,
		LEAD(A.WEIGHT, 1, -1) OVER (ORDER BY A.WEIGHT) AS LEAD_1_WT,
		LAG(A.WEIGHT, 2, -1) OVER (ORDER BY A.WEIGHT) AS LAG_2_WT
	FROM CHILDSTAT A

	GO
	/*
	FIRSTNAME	WEIGHT	LEAD_1_WT	LAG_2_WT
	ROSEMARY	123		150			-1
	ALBERT		150		167			-1
	TOMMY		167		189			123
	BUDDY		189		198			150
	FARQUAR		198		256			167
	SIMON		256		876			189
	LAUREN		876		-1			198
	*/


-- Task 4: Create two additional columns using the weight within gender
		 --1. the next previous height
		 --2. the previous lightest weight
	GO

	SELECT A.FIRSTNAME, A.GENDER, A.WEIGHT,
		LEAD(A.WEIGHT, 1, -1) OVER (PARTITION BY A.GENDER ORDER BY A.WEIGHT) AS LEAD_1_WT,
		LAG(A.WEIGHT, 2, -1) OVER (PARTITION BY A.GENDER ORDER BY A.WEIGHT) AS LAG_2_WT
	FROM CHILDSTAT A
	ORDER BY A.GENDER, A.WEIGHT

	GO
	/*
	FIRSTNAME	GENDER	WEIGHT	LEAD_1_WT	LAG_2_WT
	ROSEMARY	F 		123		876			-1
	LAUREN		F 		876		-1			-1
	ALBERT		M 		150		167			-1
	TOMMY		M 		167		189			-1
	BUDDY		M 		189		198			150
	FARQUAR		M 		198		256			167
	SIMON		M 		256		-1			189
	*/


-- RANK()/ DENSE_RANK() functions
-- =============================

-- RANK()/ DENSE_RANK() Analytic Functions
--	* Provide ranks based on ORDER BY column
--  * Recall that runners finish a race ranked as 1, 2, 3,...
--  * Tied for first?
--		* RANK() returns 1, 1, 3, 4,...
--		* DENSE_RANK() returns 1, 1, 2, 3,...
--  * Syntax
--		RANK() OVER ( ... ORDER BY ...)
--		DENSE_RANK() OVER ( ... ORDER BY ...)
--		* No arguments required
--		* ORDER BY Clause required
--		* PARTITION BY Clause not required


-- Task 5: Create ranks using ascending height within gender

	GO

	SELECT A.FIRSTNAME, A.GENDER, A.HEIGHT,
		RANK() OVER (PARTITION BY A.GENDER ORDER BY A.HEIGHT) AS HT_RANK,
		DENSE_RANK() OVER (PARTITION BY A.GENDER ORDER BY A.HEIGHT) AS HT_DENSE_RANK
	FROM CHILDSTAT A
	ORDER BY A.GENDER, A.HEIGHT

	GO
	/*
	FIRSTNAME	GENDER	HEIGHT	HT_RANK	HT_DENSE_RANK
	ROSEMARY	F 		35		1		1
	LAUREN		F 		54		2		2
	ALBERT		M 		45		1		1
	BUDDY		M 		45		1		1
	FARQUAR		M 		76		3		2
	TOMMY		M 		78		4		3
	SIMON		M 		87		5		4
	*/


-- FIRST_VALUE()/ LAST_VALUE() functions
-- =====================================

-- FIRST_VALUE()/ LAST_VALUE() Analytic Functions
--	* Retreives the first or last value within a column
--	* Takes a column name as the sole parameter
--	* Honor partition boundaries
--  * Syntax
--		FIRST_VALUE(column_name) OVER ( ... ORDER BY ...)
--		LAST_VALUE(column_name) OVER ( ... ORDER BY ...)
--		* ORDER BY Clause required
--		* PARTITION BY Clause not required

-- Task 6: Retreive names of the heaviest/lightest male/female child.

	GO

	SELECT A.FIRSTNAME, A.GENDER, A.WEIGHT,
		FIRST_VALUE(A.FIRSTNAME) OVER (PARTITION BY A.GENDER ORDER BY A.WEIGHT) AS HV_CHILD,
		LAST_VALUE(A.FIRSTNAME) OVER (PARTITION BY A.GENDER ORDER BY A.WEIGHT) AS LT_CHILD
	FROM CHILDSTAT A
	ORDER BY A.GENDER, A.WEIGHT

	GO
	/*
	FIRSTNAME	GENDER	WEIGHT	HV_CHILD	LT_CHILD
	ROSEMARY	F 		123		ROSEMARY	ROSEMARY
	LAUREN		F 		876		ROSEMARY	LAUREN
	ALBERT		M 		150		ALBERT		ALBERT
	TOMMY		M 		167		ALBERT		TOMMY
	BUDDY		M 		189		ALBERT		BUDDY
	FARQUAR		M 		198		ALBERT		FARQUAR
	SIMON		M 		256		ALBERT		SIMON
	*/

	--	* The HV_CHILD column is incorrect. This brings us the Window Clause.