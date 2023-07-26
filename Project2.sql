-- Q.1 Create new schema as alumni
CREATE DATABASE alumni;

-- Q.2 Import all .csv files into MySQL
-- Imported data through table data import wizard

-- Q.3 Run SQl command to see the structure of six tables. 
DESC college_a_hs;
DESC college_a_se;
DESC college_a_sj;
DESC college_b_hs;
DESC college_b_se;
DESC college_b_sj;

-- Q.6 Perform data cleaning on table College_A_HS and store cleaned data in view College_A_HS_V, Remove null values. 
CREATE VIEW college_A_HS_V AS (SELECT * FROM college_a_hs 
WHERE RollNo IS NOT NULL 
AND LastUpdate IS NOT NULL 
AND Name IS NOT NULL 
AND FatherName IS NOT NULL 
AND MotherName IS NOT NULL 
AND Batch IS NOT NULL
AND Degree IS NOT NULL 
AND PresentStatus IS NOT NULL 
AND HSDegree IS NOT NULL 
AND EntranceExam IS NOT NULL 
AND Institute IS NOT NULL 
AND Location IS NOT NULL);
SELECT * FROM college_A_HS_V;

-- Q.7 Perform data cleaning on table College_A_SE and store cleaned data in view College_A_SE_V, Remove null values.
CREATE VIEW College_A_SE_V 
AS (SELECT * FROM college_a_se 
WHERE RollNo IS NOT NULL 
AND LastUpdate IS NOT NULL 
AND Name IS NOT NULL 
AND FatherName IS NOT NULL 
AND MotherName IS NOT NULL 
AND Batch IS NOT NULL 
AND Degree IS NOT NULL 
AND PresentStatus IS NOT NULL 
AND Organization IS NOT NULL 
AND Location IS NOT NULL);
SELECT * FROM College_A_SE_V;

-- Q.8 Perform data cleaning on table College_A_SJ and store cleaned data in view College_A_SJ_V, Remove null values.
CREATE VIEW College_A_SJ_V 
AS (SELECT * FROM college_a_sj WHERE RollNo IS NOT NULL 
AND LastUpdate IS NOT NULL 
AND Name IS NOT NULL 
AND FatherName IS NOT NULL 
AND MotherName IS NOT NULL 
AND Batch IS NOT NULL 
AND Degree IS NOT NULL 
AND PresentStatus IS NOT NULL 
AND Organization IS NOT NULL 
AND Designation IS NOT NULL 
AND Location IS NOT NULL);
SELECT * FROM College_A_SJ_V;

-- Q.9 Perform data cleaning on table College_B_HS and store cleaned data in view College_B_HS_V, Remove null values.
CREATE VIEW College_B_HS_V 
AS (SELECT * FROM college_b_hs WHERE RollNo IS NOT NULL 
AND LastUpdate IS NOT NULL 
AND Name IS NOT NULL 
AND FatherName IS NOT NULL 
AND MotherName IS NOT NULL
AND Branch IS NOT NULL 
AND Batch IS NOT NULL 
AND Degree IS NOT NULL 
AND PresentStatus IS NOT NULL 
AND HSDegree IS NOT NULL 
AND EntranceExam IS NOT NULL 
AND Institute IS NOT NULL 
AND Location IS NOT NULL);
SELECT * FROM College_B_HS_V;

-- Q.10 Perform data cleaning on table College_B_SE and store cleaned data in view College_B_SE_V, Remove null values.
CREATE VIEW College_B_SE_V 
AS (SELECT * FROM college_b_se WHERE RollNo IS NOT NULL 
AND LastUpdate IS NOT NULL 
AND Name IS NOT NULL 
AND FatherName IS NOT NULL 
AND MotherName IS NOT NULL 
AND Branch IS NOT NULL 
AND Batch IS NOT NULL 
AND Degree IS NOT NULL 
AND PresentStatus IS NOT NULL 
AND Organization IS NOT NULL 
AND Location IS NOT NULL);
SELECT * FROM College_B_SE_V;

-- Q.11 Perform data cleaning on table College_B_SJ and store cleaned data in view College_B_SJ_V, Remove null values.
CREATE VIEW College_B_SJ_V 
AS (SELECT * FROM college_b_sj WHERE RollNo IS NOT NULL 
AND LastUpdate IS NOT NULL 
AND Name IS NOT NULL 
AND FatherName IS NOT NULL 
AND MotherName IS NOT NULL 
AND Branch IS NOT NULL 
AND Batch IS NOT NULL 
AND Degree IS NOT NULL 
AND PresentStatus IS NOT NULL 
AND Organization IS NOT NULL 
AND Designation IS NOT NULL 
AND Location IS NOT NULL);
SELECT * FROM College_B_SJ_V;

-- Q.12 Make procedure to use string function/s for converting record of Name, FatherName, MotherName into lower case for views
SELECT LOWER(Name),LOWER(FatherName),LOWER(MotherName) FROM College_A_HS_V;
SELECT LOWER(Name),LOWER(FatherName),LOWER(MotherName) FROM College_A_Se_V;
SELECT LOWER(Name),LOWER(FatherName),LOWER(MotherName) FROM College_A_Sj_V;
SELECT LOWER(Name),LOWER(FatherName),LOWER(MotherName) FROM College_B_HS_V;
SELECT LOWER(Name),LOWER(FatherName),LOWER(MotherName) FROM College_B_Se_V;
SELECT LOWER(Name),LOWER(FatherName),LOWER(MotherName) FROM College_B_Sj_V;

-- Q13.Import the created views (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V) into MS Excel and make pivot chart for location of Alumni.
-- I own a mac and sql add-in is not available on excel for macos.

-- Q.14 Write a query to create procedure get_name_collegeA using the cursor to fetch names of all students from college A.
USE alumni;
DROP PROCEDURE get_name_collegeA
DELIMITER $$
CREATE PROCEDURE get_name_collegeA 
(
         INOUT s_name TEXT(40000)
)
BEGIN 
    DECLARE finished INT DEFAULT 0;
    DECLARE namelist VARCHAR(16000) DEFAULT "";
    
    DECLARE namedetail 
           CURSOR FOR
				SELECT Name FROM college_a_hs UNION SELECT Name FROM college_a_se UNION SELECT Name FROM college_a_sj;
                
	DECLARE CONTINUE HANDLER 
            FOR NOT FOUND SET finished =1;
            
	OPEN namedetail;
    
    getame :
         LOOP
         FETCH FROM namedetail INTO namelist;
         IF finished = 1 THEN
              LEAVE getame;
		END IF;
        SET s_name = CONCAT(namelist,";",s_name);
        
        END LOOP getame;
        CLOSE namedetail;
END $$
DELIMITER ;

set @s_name = '';
call alumni.get_name_collegeA(@s_name);
select @s_name;

-- Q.15 Write a query to create procedure get_name_collegeB using the cursor to fetch names of all students from college B.
DELIMITER $$
CREATE PROCEDURE get_name_collegeB (INOUT s_name_colgB TEXT(40000))
BEGIN

DECLARE finished INT DEFAULT 0;
DECLARE name_list TEXT(40000) DEFAULT '';

DECLARE namedetail CURSOR FOR SELECT NAME FROM college_b_hs UNION SELECT Name FROM college_b_se UNION SELECT Name FROM college_b_sj;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

OPEN namedetail;

getnameB: LOOP
	FETCH namedetail INTO name_list;
    IF finished = 1 THEN
		LEAVE getnameB;
	END IF;
    
    SET s_name_colgB = CONCAT(name_list, ' ; ', s_name_colgB);
    
END LOOP getnameB;
CLOSE namedetail;

END $$
DELIMITER ;

set @s_name_colgB = '';
call get_name_collegeB(@s_name_colgB);
select @s_name_colgB;

-- Q.16 Calculate the percentage of career choice of College A and College B Alumni
-- (w.r.t Higher Studies, Self Employed and Service/Job)
-- Note: Approximate percentages are considered for career choices.
USE alumni;
DROP PROCEDURE IF EXISTS careerchoices;

DELIMITER //
CREATE PROCEDURE careerchoices ()
BEGIN
DECLARE a1, a2, a3, b1, b2, b3 DOUBLE DEFAULT 0;

SELECT COUNT(*) INTO a1 FROM college_a_hs;
SELECT COUNT(*) INTO a2 FROM college_a_se;
SELECT COUNT(*) INTO a3 FROM college_a_sj;
SELECT COUNT(*) INTO b1 FROM college_b_hs;
SELECT COUNT(*) INTO b2 FROM college_b_se;
SELECT COUNT(*) INTO b3 FROM college_b_sj;

SELECT 'Career_choice', 'College_A_Percentage', 'College_B_Percentage' UNION 
SELECT 'Higher Studies', ((a1/(a1+a2+a3))*100), ((b1/(b1+b2+b3))*100) UNION
SELECT 'Self Employed', ((a2/(a1+a2+a3))*100), ((b2/(b1+b2+b3))*100) UNION
SELECT 'Service Job', ((a3/(a1+a2+a3))*100), ((b3/(b1+b2+b3))*100);

END //
DELIMITER ;

CALL careerchoices();
































