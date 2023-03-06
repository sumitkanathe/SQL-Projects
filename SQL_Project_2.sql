-- Question-1 Create new schema as alumni.
-- Ans-
CREATE DATABASE alumni;

-- Question-2 Import all .csv files into MySQL.
-- Ans- already imported files in mysql.

-- Question-3 Run SQL command to see the structure of six tables.
-- Ans-

USE alumni;
DESC college_a_hs;
DESC college_a_se;
DESC college_a_sj;
DESC college_b_hs;
DESC college_b_se;
DESC college_b_sj;

-- Question-4  Display first 1000 rows of tables (College_A_HS, College_A_SE, College_A_SJ, College_B_HS, College_B_SE, College_B_SJ)
--            with Python.
-- Ans- python file atteched with solution.

-- Question-5 Import first 1500 rows of tables (College_A_HS, College_A_SE, College_A_SJ, College_B_HS, College_B_SE, College_B_SJ)
--            into MS Excel.
-- Ans- excel file atteched with solution.

-- Question-6 Perform data cleaning on table College_A_HS and store cleaned data in view College_A_HS_V, Remove null values. 
-- Ans-

SELECT * FROM college_a_hs;
CREATE VIEW College_A_HS_V AS (SELECT * FROM college_a_hs WHERE Rollno IS NOT NULL AND LastUpdate IS NOT NULL AND
Name IS NOT NULL AND Fathername IS NOT NULL AND Mothername IS NOT NULL AND Batch IS NOT NULL AND 
Degree IS NOT NULL AND PresentStatus IS NOT NULL AND HSDegree IS NOT NULL AND EntranceExam IS NOT NULL AND
Institute IS NOT NULL AND Location IS NOT NULL);

SELECT * FROM College_A_HS_v;

-- Question-7 Perform data cleaning on table College_A_SE and store cleaned data in view College_A_SE_V, Remove null values.
-- Ans- 

SELECT * FROM college_a_se;
CREATE VIEW College_A_SE_V AS (SELECT * FROM college_a_se WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND Name IS NOT NULL AND 
FatherName IS NOT NULL AND MotherName IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND 
Organization IS NOT NULL AND Location IS NOT NULL);

SELECT * FROM College_A_SE_V;

-- Question-8 Perform data cleaning on table College_A_SJ and store cleaned data in view College_A_SJ_V, Remove null values.
-- Ans-
SELECT * FROM college_a_sj;
CREATE VIEW College_A_SJ_V AS (SELECT * FROM college_a_sj WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND Name IS NOT NULL AND 
FatherName IS NOT NULL AND MotherName IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND 
Organization IS NOT NULL AND Designation IS NOT NULL AND Location IS NOT NULL);

SELECT * FROM College_A_SJ_V;

-- Question-9 Perform data cleaning on table College_B_HS and store cleaned data in view College_B_HS_V, Remove null values.
-- Ans- 
SELECT * FROM college_b_hs;
CREATE VIEW College_B_HS_V AS (SELECT * FROM college_b_hs WHERE Rollno IS NOT NULL AND LastUpdate IS NOT NULL AND
Name IS NOT NULL AND Fathername IS NOT NULL AND Mothername IS NOT NULL AND Branch IS NOT NULL AND Batch IS NOT NULL AND 
Degree IS NOT NULL AND PresentStatus IS NOT NULL AND HSDegree IS NOT NULL AND EntranceExam IS NOT NULL AND
Institute IS NOT NULL AND Location IS NOT NULL);

SELECT * FROM College_B_HS_V;

-- Question-10 Perform data cleaning on table College_B_SE and store cleaned data in view College_B_SE_V, Remove null values.
-- Ans-
SELECT * FROM College_b_se;
CREATE VIEW College_B_SE_V AS (SELECT * FROM college_b_se WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND Name IS NOT NULL AND 
FatherName IS NOT NULL AND MotherName IS NOT NULL AND Branch IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND 
Organization IS NOT NULL AND Location IS NOT NULL);

SELECT * FROM College_B_SE_V;

-- Question-11 Perform data cleaning on table College_B_SJ and store cleaned data in view College_B_SJ_V, Remove null values.
-- Ans-
SELECT * FROM College_b_sj;
CREATE VIEW College_B_SJ_V AS (SELECT * FROM college_b_sj WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND Name IS NOT NULL AND 
FatherName IS NOT NULL AND MotherName IS NOT NULL AND Branch IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND 
Organization IS NOT NULL AND Designation IS NOT NULL AND Location IS NOT NULL);
SELECT * FROM College_B_SJ_V;

-- Question-12 Make procedure to use string function/s for converting record of Name, FatherName, MotherName into lower case for views 
--            (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V) 
-- Ans-
DELIMITER //
CREATE PROCEDURE Lower_Case()
BEGIN
SELECT LOWER(Name) name, LOWER(FatherName) fathername, LOWER(MotherName) mothername FROM College_A_HS_V ;
SELECT LOWER(Name) name, LOWER(FatherName) fathername, LOWER(MotherName) mothername FROM College_A_SE_V ;
SELECT LOWER(Name) name, LOWER(FatherName) fathername, LOWER(MotherName) mothername FROM College_A_SJ_V ;
SELECT LOWER(Name) name, LOWER(FatherName) fathername, LOWER(MotherName) mothername FROM College_B_HS_V ;
SELECT LOWER(Name) name, LOWER(FatherName) fathername, LOWER(MotherName) mothername FROM College_B_SE_V ;
SELECT LOWER(Name) name, LOWER(FatherName) fathername, LOWER(MotherName) mothername FROM College_B_SJ_V ;
END //
DELIMITER ;

CALL Lower_Case();

-- Question-13 Import the created views (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V)
--             into MS Excel and make pivot chart for location of Alumni. 
-- Ans- excel file uploaded.

-- Question-14 Write a query to create procedure get_name_collegeA using the cursor to fetch names of all students from college A.
-- Ans-
DELIMITER //
CREATE PROCEDURE get_name_collegeA
(
	INOUT name_A text(50000)
)
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
		DECLARE namelist VARCHAR(16000) DEFAULT "";
	DECLARE namedetail
		CURSOR FOR
			SELECT name FROM college_a_hs
            union
            select name from college_a_se
            union
            select name from college_a_sj;
	DECLARE CONTINUE HANDLER 
    FOR NOT FOUND SET finished = 1;
				
                OPEN namedetail;
	get_name_collegeA1:
	LOOP 
			FETCH namedetail INTO namelist;
				IF finished = 1 THEN 
					LEAVE get_name_collegeA1;
				END IF ;
			SET name_A = CONCAT(namelist,"; ",name_A);
	END LOOP get_name_collegeA1;
    
    
    SELECT * FROM college_a_hs;
    select * from college_a_se;
    select * from college_a_sj;
 
	CLOSE namedetail;
END //
DELIMITER ;

SET @name_A = "";
CALL get_name_collegeA(@name_A);
SELECT @name_A;

-- Question-15 Write a query to create procedure get_name_collegeB using the cursor to fetch names of all students from college B.
-- Ans-

DELIMITER //
CREATE PROCEDURE get_name_collegeB
(
	INOUT name_B text(50000)
)
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
		DECLARE namelist VARCHAR(16000) DEFAULT "";
	DECLARE namedetail
		CURSOR FOR
			SELECT name FROM college_b_hs
            union
            select name from college_b_se
            union
            select name from college_b_sj;
	DECLARE CONTINUE HANDLER 
    FOR NOT FOUND SET finished = 1;
				
                OPEN namedetail;
	get_name_collegeB1:
	LOOP 
			FETCH namedetail INTO namelist;
				IF finished = 1 THEN 
					LEAVE get_name_collegeB1;
				END IF ;
			SET name_B = CONCAT(namelist,"; ",name_B);
	END LOOP get_name_collegeB1;
    
    
    SELECT * FROM college_b_hs;
    select * from college_b_se;
    select * from college_b_sj;
 
	CLOSE namedetail;
END //
DELIMITER ;

SET @name_B = "";
CALL get_name_collegeB(@name_B);
SELECT @name_B;

-- Question-16 Calculate the percentage of career choice of College A and College B Alumni
-- (w.r.t Higher Studies, Self Employed and Service/Job)
-- Note: Approximate percentages are considered for career choices.

SELECT "Higher Studies" career_choice, (SELECT COUNT(*) FROM college_a_hs)/((SELECT COUNT(*) FROM college_a_hs)+(SELECT COUNT(*) FROM college_a_se)+(select Count(*) from college_a_sj)) * 100 AS College_A_Percentage,
(SELECT COUNT(*) FROM college_b_hs)/((SELECT COUNT(*) FROM college_b_hs)+(SELECT COUNT(*) FROM college_b_se)+(select count(*) from college_b_sj)) * 100 AS College_B_Percentage
UNION
SELECT "Self Employed", (SELECT COUNT(*) FROM college_a_se)/((SELECT COUNT(*) FROM college_a_hs)+(SELECT COUNT(*) FROM college_a_se)+(select Count(*) from college_a_sj)) * 100,
(SELECT COUNT(*) FROM college_b_se)/((SELECT COUNT(*) FROM college_b_hs)+(SELECT COUNT(*) FROM college_b_se)+(select Count(*) from college_b_sj)) * 100
UNION
SELECT "Service/Job", (SELECT COUNT(*) FROM college_a_sj)/((SELECT COUNT(*) FROM college_a_hs)+(SELECT COUNT(*) FROM college_a_se)+(select Count(*) from college_a_sj)) * 100,
(SELECT COUNT(*) FROM college_b_sj)/((SELECT COUNT(*) FROM college_b_hs)+(SELECT COUNT(*) FROM college_b_se)+(select Count(*) from college_b_sj)) * 100















