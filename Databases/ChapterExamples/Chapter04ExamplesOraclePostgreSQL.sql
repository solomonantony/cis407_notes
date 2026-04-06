-- Chapter 4 Oracle Examples

-- 4.1  Testing rows using the WHERE clause 

SELECT StdFirstName, StdLastName, StdCity, StdGPA
  FROM Student
  WHERE StdGPA >= 3.7;

-- 4.2  Show all columns 

SELECT * FROM Faculty;

-- 4.3a  Expressions in SELECT and WHERE clauses 

-- PostgreSQL
SELECT FacFirstName, FacLastName, FacCity, 
       FacSalary*1.1 AS IncreasedSalary, FacHireDate 
 FROM  Faculty 
 WHERE date_part('year', FacHireDate) > 2008;

-- 4.3b
-- Oracle
SELECT FacFirstName, FacLastName, FacCity, 
       FacSalary*1.1 AS IncreasedSalary, FacHireDate 
 FROM Faculty 
 WHERE to_number(to_char(FacHireDate, 'YYYY' ) ) > 2008;

-- 4.4a  Using a function to generate today’s date 

-- PostgreSQL
SELECT FacFirstName, FacLastName, FacCity, FacHireDate 
 FROM  Faculty 
 WHERE date_part('year', FacHireDate) >= 
       date_part('year', Current_Date) - 10;

-- 4.4b 
-- Oracle
SELECT FacFirstName, FacLastName, FacCity, FacHireDate 
 FROM  Faculty 
 WHERE to_number(to_char(FacHireDate, 'YYYY' ) ) >= 
       to_number(to_char(SYSDATE, 'YYYY' ) ) - 10

-- 4.5   Using an expression in the WHERE clause 
-- List name, city and GPA of students near an A- (3.7) GPA. 
-- Their GPA have to be less than 3.7, 
-- but higher than 3.36
SELECT StdFirstName, StdLastName, StdCity, StdGPA 
 FROM  Student 
 WHERE StdGPA < 3.7 AND StdGPA >= 3.36;

-- 4.6  Exact matching on a text column with the = operator 
-- List columns of course IS480
SELECT * 
 FROM Course 
 WHERE CourseNo = 'IS480';

-- 4.7  Exact matching using the UPPER function 
-- List all courses with IS480 or is480 as the course number
SELECT * 
 FROM Course 
 WHERE UPPER(CourseNo) = 'IS480';

-- 4.8  Inexact matching with the LIKE operator 

-- List all the senior level IS courses IS4xx
SELECT * 
 FROM Course 
 WHERE CourseNo LIKE 'IS4%';

-- 4.9  Inexact matching for subtext 
-- List courses that have the text DATA in its description
SELECT * 
 FROM Course 
 WHERE CrsDesc LIKE '%DATA%';

-- 4.10  Inexact matching for text at the end 
-- List columns of courses that end with MENT
SELECT *
 FROM Course 
 WHERE CrsDesc LIKE '%MENT';

-- 4.11  Case insensitive matching for a pattern 
-- List course columns where the course number begins with fin or FIN
SELECT *
 FROM Course 
 WHERE LOWER(CourseNo) LIKE 'fin%';

-- 4.12  Inexact matching for a single character 
-- List faculty rows where the last name is 5 letters long and ends with an N
SELECT FacFirstName, FacLastName, FacRank
 FROM Faculty 
 WHERE FacLastName LIKE '____N';

-- 4.13  Comparing a date column to date constants 
-- List the hiring date of faculty hired in 2011 or 2012
SELECT FacFirstName, FacLastName, FacHireDate 
 FROM Faculty 
 WHERE FacHireDate BETWEEN '1-Jan-2011' AND '31-Dec-2012';

-- 4.14a  (PostgreSQL) Using a proprietary function to retrieve month number 
-- List the faculty name, and hiring date of faculty hired in April of any year.
-- PostgreSQL
SELECT FacFirstName, FacLastName, FacHireDate 
 FROM  Faculty 
 WHERE date_part('month', FacHireDate) = 4;

-- 4.14b  (Oracle) Using proprietary functions to retrieve month number 

- Oracle
SELECT FacFirstName, FacLastName, FacHireDate 
 FROM  Faculty 
 WHERE to_number(to_char(FacHireDate, 'MM' ) ) = 4

-- 4.15  Testing for nulls 
-- List the offering number, and course number of summer 
-- 2020 offerings without an assigned faculty
SELECT OfferNo, CourseNo 
 FROM Offering 
 WHERE FacNo IS NULL 
   AND OffTerm = 'SUMMER' 
   AND OffYear = 2020;

-- 4.16  Complex logical expression 
-- List offering number, course number, faculty number, term, and year for course 
-- offerings scheduled in fall 2019 or winter 2020
SELECT OfferNo, CourseNo, FacNo, OffTerm, OffYear
 FROM Offering 
 WHERE (OffTerm = 'FALL' AND OffYear = 2019) 
    OR (OffTerm = 'WINTER' AND OffYear = 2020);

-- 4.17   Join tables but show columns from one table only 
-- List offering number, course number, days, and time of offerings
-- containing the word database or programming in the description
-- and taught in spring 2020

SELECT OfferNo, Offering.CourseNo, OffDays, OffTime 
 FROM Offering, Course 
 WHERE OffTerm = 'SPRING' AND OffYear = 2020
   AND (CrsDesc LIKE '%DATABASE%' 
    OR CrsDesc LIKE '%PROGRAMMING%') 
   AND Course.CourseNo = Offering.CourseNo;

-- 4.18  Join tables and show columns from both tables 
-- List offer number, course number, and name of faculty
-- for IS course offereing scheduled in fall 2019 taught by assistant 
-- professor using cross product join
SELECT OfferNo, CourseNo, FacFirstName, FacLastName 
 FROM Offering, Faculty 
 WHERE OffTerm = 'FALL' AND OffYear = 2019 
   AND FacRank = 'ASST' AND CourseNo LIKE 'IS%'
   AND Faculty.FacNo = Offering.FacNo;

-- 4.19  Join tables using a join operation in the FROM clause 
-- List the offer number, course number, and name of faculty
-- of IS course scheduled in fall 2019 that are taught by assistant
-- professors - using inner join
SELECT OfferNo, CourseNo, FacFirstName, FacLastName  
 FROM Offering INNER JOIN Faculty 
   ON Faculty.FacNo = Offering.FacNo
 WHERE OffTerm = 'FALL' AND OffYear = 2019 
   AND FacRank = 'ASST' AND CourseNo LIKE 'IS%';

-- 4.20  Grouping on a single column 
-- SUmmarize average GPA by major
SELECT StdMajor, AVG(StdGPA) AS AvgGPA
 FROM Student 
 GROUP BY StdMajor;

-- 4.21  Counting rows and unique column values 
-- Summarize number of offerings and unique courses by year
SELECT OffYear, COUNT(*) AS NumOfferings, 
       COUNT(DISTINCT CourseNo) AS NumCourses
 FROM Offering
 GROUP BY OffYear;

-- 4.22  Grouping with row conditions 
-- Summarize the GPA of upper division students by major
SELECT StdMajor, AVG(StdGPA) AS AvgGpa 
 FROM Student 
 WHERE StdClass = 'JR' OR StdClass = 'SR'
 GROUP BY StdMajor;

-- 4.23  Grouping with row and group conditions 
-- Summarize average GPA of upper division students by major. 
-- Only majors with average GPA > 3.1
SELECT StdMajor, AVG(StdGPA) AS AvgGpa 
 FROM Student 
 WHERE StdClass IN ('JR', 'SR')
 GROUP BY StdMajor 
 HAVING AVG(StdGPA) > 3.1;

-- 4.24  Grouping all rows 
-- List the number of upper division students and their average GPA
SELECT COUNT(*) AS StdCnt, AVG(StdGPA) AS AvgGPA 
 FROM Student 
 WHERE StdClass IN ('JR','SR');

-- 4.25  Grouping on two columns 
-- Summarize the minimum and maximum of GPA by major and class

SELECT StdMajor, StdClass, MIN(StdGPA) AS MinGPA, 
       MAX(StdGPA) AS MaxGPA, COUNT(*) AS CountRows
 FROM Student 
 GROUP BY StdMajor, StdClass;

-- 4.26  Combining grouping and joins 
-- Summarize the number of IS courses offerings 
-- by course descriptio
SELECT CrsDesc, COUNT(*) AS OfferCount 
 FROM Course, Offering  
 WHERE Course.CourseNo = Offering.CourseNo 
   AND Course.CourseNo LIKE 'IS%'  
 GROUP BY CrsDesc;

-- 4.27  Sorting on a single column 
-- List GPA, name, city, state of juniors.  Order the 
-- result by GPA in ascending order.
SELECT StdGPA, StdFirstName, StdLastName, StdCity,
       StdState 
 FROM Student 
 WHERE StdClass = 'JR'
 ORDER BY StdGPA;

-- 4.28  Sorting on two columns with descending order 
-- List the faculty data in ascending order of rank and
-- descending order of salary
SELECT FacRank, FacSalary, FacFirstName, FacLastName,
       FacDept 
 FROM Faculty 
 ORDER BY FacRank, FacSalary DESC;

-- 4.29  Result with duplicates 
-- List the city and state of faculty
SELECT FacCity, FacState 
  FROM Faculty;

-- 4.30  Eliminating duplicates with DISTINCT 
-- List the unique city and state of faculty
SELECT DISTINCT FacCity, FacState 
 FROM Faculty;

-- 4.31  Depict many parts of the SELECT statement 

SELECT CourseNo, Enrollment.OfferNo, 
       AVG(EnrGrade) AS AvgGrade
 FROM Enrollment, Offering
 WHERE CourseNo LIKE 'IS%' AND OffYear = 2019 
   AND OffTerm = 'FALL' 
   AND Enrollment.OfferNo = Offering.OfferNo
 GROUP BY CourseNo, Enrollment.OfferNo
 HAVING  COUNT(*) > 1
 ORDER BY CourseNo, 3 DESC;

-- 4.31a  SELECT statement before grouping in Example 4.31 

SELECT CourseNo, Offering.OfferNo, StdNo, EnrGrade
 FROM Enrollment, Offering
 WHERE Enrollment.OfferNo = Offering.OfferNo
   AND CourseNo LIKE 'IS%' 
   AND OffYear = 2019 
   AND OffTerm = 'FALL' 
   AND Enrollment.OfferNo = Offering.OfferNo
 ORDER BY CourseNo, OfferNo ;

-- 4.31b  Grouping and aggregate functions added to Example 4.31A 

SELECT CourseNo, Offering.OfferNo, 
       AVG(EnrGrade) AS AvgGrade
 FROM Enrollment, Offering
 WHERE CourseNo LIKE 'IS%' AND OffYear = 2019 
   AND OffTerm = 'FALL' 
   AND Enrollment.OfferNo = Offering.OfferNo
 GROUP BY CourseNo, Offering.OfferNo;

-- 4.32  Joining two tables 

SELECT StdFirstName, StdLastName, OfferNo, EnrGrade 
 FROM Student, Enrollment 
 WHERE Student.StdNo = Enrollment.StdNo
   AND EnrGrade >= 3.5;

-- 4.33  Join with duplicates 

SELECT StdFirstName, StdLastName 
 FROM Student, Enrollment 
 WHERE EnrGrade >= 3.5 
   AND Student.StdNo = Enrollment.StdNo;

-- 4.34  Join with duplicates removed 

SELECT DISTINCT StdFirstName, StdLastName 
 FROM Student, Enrollment 
 WHERE EnrGrade >= 3.5 
   AND Student.StdNo = Enrollment.StdNo;

-- 4.35  Joining three tables with columns from only two tables 
-- List student named, offering number in Fall 2019, and grade 
-- greater than 3.7 

SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo =  Enrollment.OfferNo 
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- 4.36  Joining three tables with columns from only two tables 
-- List Leonard Vince's teaching schedule in fall 2019.  List the
-- offering number, course number, number of units, 
-- days, location and time
SELECT OfferNo, Offering.CourseNo, CrsUnits, OffDays,
       OffLocation, OffTime
 FROM Faculty, Course, Offering 
 WHERE Faculty.FacNo = Offering.FacNo
   AND Offering.CourseNo = Course.CourseNo 
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND FacFirstName = 'LEONARD' 
   AND FacLastName = 'VINCE';

-- 4.37  Joining four tables 
-- List student Bob Norbert's course schedule for spring 2020. Include
-- course details and faculty name
SELECT Offering.OfferNo, Offering.CourseNo, OffDays,
       OffLocation, OffTime, FacFirstName, FacLastName
 FROM Faculty, Offering, Enrollment, Student 
 WHERE Offering.OfferNo = Enrollment.OfferNo
   AND Student.StdNo = Enrollment.StdNo 
   AND Faculty.FacNo = Offering.FacNo 
   AND OffYear = 2020 AND OffTerm = 'SPRING' 
   AND StdFirstName = 'BOB' 
   AND StdLastName = 'NORBERT';

-- 4.38  Joining five tables 
-- List student Bob Norbert's course schedule for spring 2020. Include
-- course credit hours and faculty name
SELECT Offering.OfferNo, Offering.CourseNo, OffDays,
       OffLocation, OffTime, CrsUnits, FacFirstName,
       FacLastName
 FROM Faculty, Offering, Enrollment, Student, Course
 WHERE Faculty.FacNo = Offering.FacNo 
   AND Offering.OfferNo = Enrollment.OfferNo
   AND Student.StdNo = Enrollment.StdNo
   AND Offering.CourseNo = Course.CourseNo
   AND OffYear = 2020 AND OffTerm = 'SPRING' 
   AND StdFirstName = 'BOB'
   AND StdLastName = 'NORBERT';

-- 4.39  Join two tables using the join operator style 
-- List name, city, and grade of students whith high 
-- grade (>3.5) in a course offering

SELECT StdFirstName, StdLastName, StdCity, EnrGrade
 FROM Student INNER JOIN Enrollment 
   ON Student.StdNo = Enrollment.StdNo
 WHERE EnrGrade >= 3.5;

-- 4.40  Join three tables using the join operator style 
-- List name, city, and grade of students whith high 
-- grade (>3.5) in a course offering in fall 2019
SELECT StdFirstName, StdLastName, StdCity, EnrGrade
 FROM  Student INNER JOIN Enrollment 
     ON Student.StdNo = Enrollment.StdNo 
  INNER JOIN Offering
    ON Offering.OfferNo = Enrollment.OfferNo
 WHERE EnrGrade >= 3.5 AND OffTerm = 'FALL' 
   AND OffYear = 2019;

-- 4.41  Join four tables using the join operator style 
-- -- List name, city, and grade of students whith high 
-- grade (>3.5) in a course offering in fall 2019
-- taught by Leonard Vince
SELECT StdFirstName, StdLastName, StdCity, EnrGrade
 FROM Student INNER JOIN Enrollment 
       ON Student.StdNo = Enrollment.StdNo 
  INNER JOIN Offering 
     ON Offering.OfferNo = Enrollment.OfferNo 
  INNER JOIN Faculty ON Faculty.FacNo = Offering.FacNo
 WHERE EnrGrade >= 3.5 AND OffTerm = 'FALL' 
   AND OffYear = 2019 AND FacFirstName = 'LEONARD'
   AND FacLastName = 'VINCE';

-- 4.42  Join five tables using the join operator style 
-- List name, city, course credit hours, description, 
-- and grade of students whith high 
-- grade (>3.5) in a course offering in fall 2019
-- taught by Leonard Vince


SELECT StdFirstName, StdLastName, StdCity, EnrGrade, CrsUnits. CrsDesc
 FROM Student INNER JOIN Enrollment 
       ON Student.StdNo = Enrollment.StdNo 
  INNER JOIN Offering 
     ON Offering.OfferNo = Enrollment.OfferNo 
  INNER JOIN Faculty ON Faculty.FacNo = Offering.FacNo
  INNER JOIN Course ON Offering.CourseNo = Course.CourseNo
 WHERE EnrGrade >= 3.5 AND OffTerm = 'FALL' 
   AND OffYear = 2019 AND FacFirstName = 'LEONARD'
   AND FacLastName = 'VINCE';

-- 4.43  Joining two tables without matching on a primary and foreign key 
-- List students who are also a faculty. 
SELECT Student.* 
 FROM Student, Faculty 
 WHERE StdNo = FacNo;

-- 4.44  Self-join 
-- List subordinates of faculty who have a higher salry
-- than their supervisor
SELECT Sub.FacNo as sub_facno, Sub.FacLastName as sub_lastname, Sub.FacSalary as sub_salary, 
       Super.FacNo as super_facno, Super.FacLastName as super_lastname, Super.FacSalary as super_salary
 FROM Faculty Sub, Faculty Super
 WHERE Sub.FacSupervisor = Super.FacNo 
   AND Sub.FacSalary > Super.FacSalary;

-- 4.45  Simple join cycle using table alias names 
-- Name the subordinate faculty members, and course number 
-- in which the subordinate faculty member teaches the same
-- course as the supervisor in 2020
SELECT FacFirstName AS SubFacFirstName, 
       FacLastName AS SubFacLastName, O1.CourseNo
FROM Faculty, Offering O1, Offering O2
 WHERE Faculty.FacNo = O1.FacNo 
   AND Faculty.FacSupervisor = O2.FacNo 
   AND O1.CourseNo = O2.CourseNo
   AND O1.OffYear = 2020 AND O2.OffYear = 2020;

-- 4.46  Simple join cycle with a self-join 
-- list names of subordinates and supervisors and 
-- course number that both teach in 2020
SELECT F1.FacFirstName AS SubFacFirstName, 
       F1.FacLastName AS SubFacLastName, 
       F2.FacFirstName AS SupFacFirstName, 
       F2.FacLastName AS SupFacLastName, O1.CourseNo
FROM Faculty F1, Faculty F2, Offering O1, Offering O2
 WHERE F1.FacNo = O1.FacNo 
   AND F1.FacSupervisor = O2.FacNo 
   AND F1.FacSupervisor = F2.FacNo
   AND O1.CourseNo = O2.CourseNo
   AND O1.OffYear = 2020 AND O2.OffYear = 2020;

-- 4.47  Join with grouping on multiple columns 
-- List course number, offering number, number of students enrolled for
-- courses in the spring 2020 term.
SELECT CourseNo, Enrollment.OfferNo, 
       Count(*) AS NumStudents
 FROM Offering, Enrollment
 WHERE Offering.OfferNo = Enrollment.OfferNo
   AND OffYear = 2020 AND OffTerm = 'SPRING' 
 GROUP BY Enrollment.OfferNo, CourseNo;

-- 4.48  Joins, grouping, and a grouping condition 
-- list course number, offer number, average student GPA
-- for course offerings in fall 2019 in which the
-- average GPA is greater than 3.0
SELECT CourseNo, Enrollment.OfferNo, Avg(StdGPA) AS AvgGPA
 FROM Student, Offering, Enrollment
 WHERE Offering.OfferNo = Enrollment.OfferNo
   AND Enrollment.StdNo = Student.StdNo 
   AND OffYear = 2019 AND OffTerm = 'FALL' 
 GROUP BY CourseNo, Enrollment.OfferNo 
 HAVING Avg(StdGPA) > 3.0;

-- 4.49a (PostgreSQL)  Joins and grouping on a computed column 
-- Extract the hiring year, offering year, number of courses 
-- taught by faculty hired after 2006
SELECT date_part('year',FacHireDate) AS FacHireYear, OffYear, 
       COUNT(*) as NumCourses
 FROM Offering, Faculty
 WHERE Offering.FacNo = Faculty.FacNo 
   AND date_part('year',FacHireDate) > 2006
 GROUP BY date_part('year',FacHireDate), OffYear;

-- 4.49b (Oracle)  Joins and grouping on a computed column 

SELECT to_number(to_char(FacHireDate, 'YYYY') ) AS FacHireYear, OffYear, 
       COUNT(*) as NumCourses
 FROM Offering, Faculty
 WHERE Offering.FacNo = Faculty.FacNo 
   AND to_number(to_char(FacHireDate, 'YYYY') ) > 2006
 GROUP BY to_number(to_char(FacHireDate, 'YYYY' ) ), OffYear;

-- 4.50  Joins and grouping on five tables 

SELECT FacFirstName, FacLastName, Offering.OfferNo, Course.CourseNo,
       AVG(StdGPA) AS AvgGPA, COUNT(*) AS EnrollCnt
 FROM Faculty, Student, Offering, Course, Enrollment
 WHERE Faculty.FacNo = Offering.FacNo
   AND Offering.OfferNo = Enrollment.OfferNo
   AND Course.CourseNo = Offering.CourseNo
   AND Enrollment.StdNo = Student.StdNo
   AND Offering.OffYear = 2020
   AND Offering.OffTerm = 'SPRING'
 GROUP BY FacFirstName, FacLastName, Offering.OfferNo, Course.CourseNo
 HAVING COUNT(*) > 2
 ORDER BY AVG(StdGPA) DESC;

-- 4.51  UNION query 

SELECT FacNo AS PerNo, FacFirstName AS FirstName,
       FacLastName AS LastName, FacCity AS City, 
       FacState AS State 
 FROM Faculty
	UNION 
SELECT StdNo AS PerNo, StdFirstName AS FirstName,
       StdLastName AS LastName, StdCity AS City, 
       StdState AS State 
 FROM Student;

-- 4.52  INTERSECT query 

SELECT FacNo AS PerNo, FacFirstName AS FirstName, 
       FacLastName AS LastName, FacCity AS City, 
       FacState AS State 
 FROM Faculty
   INTERSECT
SELECT StdNo AS PerNo, StdFirstName AS FirstName, 
       StdLastName AS LastName, StdCity AS City, 
       StdState AS State 
 FROM Student;

-- 4.53 (Oracle)  Difference query 

SELECT FacNo AS PerNo, FacFirstName AS FirstName, 
       FacLastName AS LastName, FacCity AS City, 
       FacState AS State 
 FROM Faculty
     MINUS
SELECT StdNo AS PerNo, StdFirstName AS FirstName, 
       StdLastName AS LastName, StdCity AS City, 
       StdState AS State 
 FROM Student;

-- 4.53 (PostgreSQL)  Difference query 


SELECT FacNo AS PerNo, FacFirstName AS FirstName, 
       FacLastName AS LastName, FacCity AS City, 
       FacState AS State 
 FROM Faculty
     EXCEPT
SELECT StdNo AS PerNo, StdFirstName AS FirstName, 
       StdLastName AS LastName, StdCity AS City, 
       StdState AS State 
 FROM Student;

-- 4.54  Single row insert 

INSERT INTO Student 
 (StdNo, StdFirstName, StdLastName, 
  StdCity, StdState, StdZip, StdClass, StdMajor, StdGPA) 
 VALUES ('999999999', 'JOE', 'STUDENT', 'SEATAC', 
         'WA', '98042-1121', 'FR', 'IS', 0.0);

CREATE TABLE ISStudent
( StdNo 	    CHAR(11)    CONSTRAINT StdNoRequiredISStd NOT NULL,
  StdFirstName  VARCHAR(50) CONSTRAINT StdFirstNameRequiredISStd NOT NULL,
  StdLastName   VARCHAR(50) CONSTRAINT StdLastNameRequiredISStd NOT NULL,
  StdCity	    VARCHAR(50) CONSTRAINT StdCityRequiredISStd NOT NULL,
  StdState	    CHAR(2)	    CONSTRAINT StdStateRequiredISStd NOT NULL,
  StdZip	    CHAR(10)    CONSTRAINT StdZipRequiredISStd NOT NULL,
  StdMajor	    CHAR(6),
  StdClass	    CHAR(6),
  StdGPA	    DECIMAL(3,2) DEFAULT 0,	
  CONSTRAINT PKISStudent PRIMARY KEY (StdNo),	
  CONSTRAINT ValidGPAISStd CHECK ( StdGPA BETWEEN 0 AND 4 ),
  CONSTRAINT ValidStdClassISStd CHECK (StdClass IN ('FR','SO', 'JR','SR')),
  CONSTRAINT MajorDeclaredISStd CHECK 
               ( StdClass IN ('FR','SO') OR StdMajor IS NOT NULL ) );

-- 4.55  Multiple row insert 

-- This query assumes that you have created a new table (ISStudent) with the same columns as Student.
INSERT INTO ISStudent 
 SELECT * FROM Student WHERE StdMajor = 'IS';

-- 4.56  Single column update 

UPDATE Faculty 
 SET FacSalary = FacSalary * 1.1 
 WHERE FacDept = 'MS';

-- 4.57  Update multiple columns 

UPDATE Student 
 SET StdMajor = 'ACCT', StdClass = 'SO' 
 WHERE StdFirstName = 'HOMER' 
   AND StdLastName = 'WELLS';

-- 4.58  Delete selected rows 

DELETE FROM Student 
 WHERE StdMajor = 'IS' AND StdClass = 'SR';

-- 4.59  Delete all rows in a table 

-- This query assumes that you have created a new table (ISStudent) with the same columns as Student.

DELETE FROM ISStudent;

-- 4.60  Misspelled keywords 

-- Original statement with syntax errors
SELECT OfferNo, CourseNo, FacNo 
 FROMM Offering 
 WHERRE OffTerm = 'FALL' 
    AND OffYear = 2019;

-- Corrected statement without syntax errors
SELECT OfferNo, CourseNo, FacNo 
 FROM Offering 
 WHERE OffTerm = 'FALL' 
   AND OffYear = 2019;

-- 4.61  Unqualified column name 

-- Original statement with syntax errors
SELECT StdFirstName, StdLastName, OfferNo 
 FROM Student, Enrollment, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo 
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- Corrected statement without syntax errors
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo 
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- 4.62  Missing table 

-- Original statement with syntax errors
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo 
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- Corrected statement without syntax errors
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Offering, Enrollment
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo 
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- 4.63  Row condition in HAVING clause 

-- Original statement with syntax errors
SELECT CourseNo, Enrollment.OfferNo, 
       Avg(StdGPA) AS AvgGPA
 FROM Student, Offering, Enrollment
 WHERE Offering.OfferNo = Enrollment.OfferNo
   AND Enrollment.StdNo = Student.StdNo 
   AND OffTerm = 'FALL' 
 GROUP BY CourseNo, Enrollment.OfferNo 
 HAVING Avg(StdGPA) > 3.0 AND OffYear = 2019;

-- Corrected statement without syntax errors
SELECT CourseNo, Enrollment.OfferNo, 
       Avg(StdGPA) AS AvgGPA
 FROM Student, Offering, Enrollment
 WHERE Offering.OfferNo = Enrollment.OfferNo
   AND Enrollment.StdNo = Student.StdNo 
   AND OffTerm = 'FALL' AND OffYear = 2019
 GROUP BY CourseNo, Enrollment.OfferNo 
 HAVING Avg(StdGPA) > 3.0;

-- 4.64  Missing column in GROUP BY clause 

-- Original statement with syntax errors
SELECT CourseNo, Enrollment.OfferNo, 
       Avg(StdGPA) AS AvgGPA
 FROM Student, Offering, Enrollment
 WHERE Offering.OfferNo = Enrollment.OfferNo
   AND Enrollment.StdNo = Student.StdNo 
   AND OffTerm = 'FALL' AND OffYear = 2019
 GROUP BY CourseNo
 HAVING Avg(StdGPA) > 3.0;

-- Corrected statement without syntax errors
SELECT CourseNo, Enrollment.OfferNo, 
       Avg(StdGPA) AS AvgGPA
 FROM Student, Offering, Enrollment
 WHERE Offering.OfferNo = Enrollment.OfferNo
   AND Enrollment.StdNo = Student.StdNo 
   AND OffTerm = 'FALL' AND OffYear = 2019
 GROUP BY CourseNo, Enrollment.OfferNo
 HAVING Avg(StdGPA) > 3.0;

-- 4.65  Extra table 

-- Original statement with redundancy error (extra table)
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering, Course
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo
   AND Course.CourseNo = Offering.CourseNo
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- Corrected statement with Course table removed
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- 4.66  Unnecessary GROUP BY clause 

-- Original statement with redundancy error (unnecessary GROUP BY clause)
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo 
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7
GROUP BY StdFirstName, StdLastName, Enrollment.OfferNo;

-- Corrected statement without unnecessary GROUP BY clause
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo 
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- 4.67  Missing parentheses 

-- Original statement with semantic error (missing parentheses)
SELECT OfferNo, CourseNo, FacNo, OffYear, OffTerm 
 FROM Offering 
 WHERE OffTerm = 'SPRING' OR OffTerm = 'SUMMER'
   AND OffYear = 2019;

-- Corrected statement with parentheses added
SELECT OfferNo, CourseNo, FacNo, OffYear, OffTerm 
 FROM Offering 
 WHERE ( OffTerm = 'SPRING' OR OffTerm = 'SUMMER' )
   AND OffYear = 2019;

-- 4.68  Missing join condition 

-- Original statement with semantic error (missing join condition)
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- Corrected statement with join condition added
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND Enrollment.OfferNo = Offering.OfferNo
   AND OffYear = 2019 AND OffTerm = 'FALL' 
   AND EnrGrade >= 3.7;

-- 4.69  Missing condition 

--Original statement with semantic error (missing condition)
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo 
   AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- Corrected statement with condition added
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo 
   AND OffTerm = 'FALL' AND OffYear = 2019
   AND EnrGrade >= 3.7;

-- 4.70  Poor SQL coding practices

-- Original statement with poor coding practices
 SELECT Offering.OfferNo, Offering.CourseNo, OffDays,
       OffLocation, OffTime, CrsUnits, FacFirstName,
    FacLastName FROM Faculty, Offering, Enrollment, Student, Course WHERE Faculty.FacNo = Offering.FacNo AND
Offering.OfferNo
  = Enrollment.OfferNo
AND Offering.CourseNo = Course.CourseNo
          AND OffYear = '2020' AND OffTerm = 'SPRING'   
  AND Student.StdNo = Enrollment.StdNo
 AND StdFirstName LIKE 'BOB' AND StdLastName = 'NORBERT';

-- Corrected statement with good coding practices
SELECT Offering.OfferNo, Offering.CourseNo, OffDays,
       OffLocation, OffTime, CrsUnits, FacFirstName,
       FacLastName
 FROM Faculty, Offering, Enrollment, Student, Course
 WHERE Faculty.FacNo = Offering.FacNo 
   AND Offering.OfferNo = Enrollment.OfferNo
   AND Student.StdNo = Enrollment.StdNo
   AND Offering.CourseNo = Course.CourseNo
   AND OffYear = 2020 AND OffTerm = 'SPRING' 
   AND StdFirstName = 'BOB'
   AND StdLastName = 'NORBERT';
