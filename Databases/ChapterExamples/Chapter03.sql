--p45
drop table student;
create table Student
  (stdNo char(11),
  stdFirstName varchar(30),
  stdLastName VARCHAR(30),
  stdCity varchar(30),
  stdState char(2),
  stdZIP char(10),
  stdMajor char(6),
  stdClass char(6), 
  stdGPA decimal(3,2));

INSERT INTO Student
	(StdNo, StdFirstName, StdLastName, StdCity,
	 StdState,  StdZip, StdMajor, StdClass, stdGPA)
	VALUES ('123-45-6789','HOMER','WELLS','SEATTLE','WA','98121-1111', 'IS','FR',3.00);


INSERT INTO Student
	(StdNo, StdFirstName, StdLastName, StdCity,
	  StdState,  StdZip, StdMajor, StdClass, stdGPA)
	VALUES ('124-56-7890','BOB','NORBERT','BOTHELL','WA','98011-2121','FIN','JR',2.70);

INSERT INTO Student
	(StdNo, StdFirstName, StdLastName, StdCity,
     StdState,  StdZip, StdMajor, StdClass, stdGPA)
	VALUES ('234-56-7890','CANDY','KENDALL','TACOMA','WA','99042-3321', 'ACCT','JR',3.50);
--p48
drop table student;
create table Student
  (stdNo char(11),
  stdFirstName varchar(30),
  stdLastName VARCHAR(30),
  stdCity varchar(30),
  stdState char(2),
  stdZIP char(10),
  stdMajor char(6),
  stdClass char(6), 
  stdGPA decimal(3,2),
  constraint pkStudent primary key (StdNo));
  
--p49
CREATE TABLE Course (
CourseNo	CHAR(6),
CrsDesc		VARCHAR(50) CONSTRAINT CrsDescRequired NOT NULL,
CrsUnits	INTEGER,
CONSTRAINT CoursePK PRIMARY KEY (CourseNo), 
CONSTRAINT UniqueCrsDesc UNIQUE (CrsDesc)  );

--p36
INSERT INTO course
	(CourseNo, CrsDesc, CrsUnits)
	VALUES ('IS320','FUNDAMENTALS OF BUSINESS PROGRAMMING',4 );

INSERT INTO course
	(CourseNo, CrsDesc, CrsUnits)
	VALUES ( 'IS460','SYSTEMS ANALYSIS',4);
	
INSERT INTO course
	(CourseNo, CrsDesc, CrsUnits)
	VALUES ( 'IS470','BUSINESS DATA COMMUNICATIONS',4);

INSERT INTO course
	(CourseNo, CrsDesc, CrsUnits)
	VALUES ('IS480','FUNDAMENTALS OF DATABASE MANAGEMENT',4 );

--p49
CREATE TABLE Enrollment (
OfferNo		INTEGER,
StdNo		CHAR(11),
EnrGrade	DECIMAL(3,2),
CONSTRAINT PKEnrollment PRIMARY KEY (OfferNo, StdNo));

--p50
drop table Enrollment;
CREATE TABLE Enrollment (
OfferNo		INTEGER,
StdNo		CHAR(11),
EnrGrade	DECIMAL(3,2),
CONSTRAINT PKEnrollment PRIMARY KEY (OfferNo, StdNo),
CONSTRAINT FKOffering FOREIGN KEY (OfferNo) REFERENCES Offering,
CONSTRAINT FKStudent FOREIGN KEY (StdNo) REFERENCES Student);

--p50

CREATE TABLE Offering (
OfferNo INTEGER,
OffLocation VARCHAR(30),
OffDays CHAR(6) DEFAULT 'MW',
OffTerm CHAR(6) CONSTRAINT OffTermRequired NOT NULL,
OffYear INTEGER DEFAULT 2022 CONSTRAINT OffYearRequired NOT NULL,
CourseNo CHAR(6) CONSTRAINT OffCourseNoRequired NOT NULL,
FacNo CHAR(11),
OffTime VARCHAR(10),
CONSTRAINT OfferingPK PRIMARY KEY (OfferNo),
CONSTRAINT CourseFK FOREIGN KEY (CourseNo) REFERENCES Course,
CONSTRAINT FacultyFK FOREIGN KEY (FacNo) REFERENCES Faculty );

--p51
CREATE TABLE Faculty (
FacNo		CHAR(11),
FacFirstName	VARCHAR(30) CONSTRAINT FacFirstNameRequired NOT NULL,
FacLastName	VARCHAR(30) CONSTRAINT FacLastNameRequired NOT NULL,
FacCity		VARCHAR(30) CONSTRAINT FacCityRequired NOT NULL,
FacState	CHAR(2) CONSTRAINT FacStateRequired NOT NULL,
FacZipCode	CHAR(10) CONSTRAINT FacZipRequired NOT NULL,
FacHireDate	DATE,
FacDept		CHAR(6),
FacRank		CHAR(4),
FacSalary	DECIMAL(10,2),
FacSupervisor	CHAR(11),
CONSTRAINT FacultyPK PRIMARY KEY (FacNo), 
CONSTRAINT SupervisorFK FOREIGN KEY (FacSupervisor) REFERENCES Faculty );

--p52
INSERT INTO Faculty
	(FacNo, FacFirstName, FacLastName, FacCity, FacState,
	 FacDept, FacRank, FacSalary, FacSupervisor, FacHireDate, FacZipCode)
	 VALUES ('543-21-0987','VICTORIA','EMMANUEL','BOTHELL','WA','MS','PROF',120000.0,NULL,'15-Apr-2008','98011-2242');

INSERT INTO Faculty
	(FacNo, FacFirstName, FacLastName, FacCity, FacState,
	 FacDept, FacRank, FacSalary, FacSupervisor, FacHireDate, FacZipCode)
	 VALUES ('765-43-2109','NICKI','MACON','BELLEVUE','WA','FIN','PROF',65000.00,NULL,'11-Apr-2009','98015-9945');

INSERT INTO Faculty
	(FacNo, FacFirstName, FacLastName, FacCity, FacState,
	 FacDept, FacRank, FacSalary, FacSupervisor, FacHireDate, FacZipCode)
	 VALUES ('654-32-1098','LEONARD','FIBON','SEATTLE','WA','MS','ASSC',70000.00,'543-21-0987','01-May-2006','98121-0094');

INSERT INTO Faculty
	(FacNo, FacFirstName, FacLastName, FacCity, FacState,
	 FacDept, FacRank, FacSalary, FacSupervisor, FacHireDate, FacZipCode)
	 VALUES ('098-76-5432','LEONARD','VINCE','SEATTLE','WA','MS','ASST',35000.00,'654-32-1098','10-Apr-2007','98111-9921');

INSERT INTO Faculty
	(FacNo, FacFirstName, FacLastName, FacCity, FacState,
	 FacDept, FacRank, FacSalary, FacSupervisor, FacHireDate, FacZipCode)
	 VALUES ('876-54-3210','CRISTOPHER','COLAN','SEATTLE','WA','MS','ASST',40000.00,'654-32-1098','01-Mar-2011','98114-1332');

INSERT INTO Faculty
	(FacNo, FacFirstName, FacLastName, FacCity, FacState,
	 FacDept, FacRank, FacSalary, FacSupervisor, FacHireDate, FacZipCode)
	 VALUES ('987-65-4321','JULIA','MILLS','SEATTLE','WA','FIN','ASSC',75000.00,'765-43-2109','15-Mar-2012','98114-9954');

--p55
CREATE TABLE Enrollment (
OfferNo		INTEGER NOT NULL,
StdNo		CHAR(11) NOT NULL,
EnrGrade	DECIMAL(3,2) DEFAULT 0,
CONSTRAINT EnrollmentPK PRIMARY KEY (OfferNo, StdNo),
CONSTRAINT OfferingFK FOREIGN KEY (OfferNo) REFERENCES Offering ON DELETE CASCADE,
CONSTRAINT StudentFK FOREIGN KEY (StdNo) REFERENCES Student ON DELETE CASCADE );

--p56
Drop table Enrollment;
DROP TABLE Student;

CREATE TABLE Student
( StdNo 	    CHAR(11)    CONSTRAINT StdNoRequired NOT NULL,
  StdFirstName  VARCHAR(50) CONSTRAINT StdFirstNameRequired NOT NULL,
  StdLastName   VARCHAR(50) CONSTRAINT StdLastNameRequired NOT NULL,
  StdCity	    VARCHAR(50) CONSTRAINT StdCityRequired NOT NULL,
  StdState	    CHAR(2)	    CONSTRAINT StdStateRequired NOT NULL,
  StdZip	    CHAR(10)    CONSTRAINT StdZipRequired NOT NULL,
  StdMajor	    CHAR(6),
  StdClass	    CHAR(6),
  StdGPA	    DECIMAL(3,2) DEFAULT 0,	
  CONSTRAINT PKStudent PRIMARY KEY (StdNo),	
  CONSTRAINT ValidGPA CHECK ( StdGPA BETWEEN 0 AND 4 ),
  CONSTRAINT ValidStdClass CHECK (StdClass IN ('FR','SO', 'JR','SR')),
  CONSTRAINT MajorDeclared CHECK 
               ( StdClass IN ('FR','SO') OR StdMajor IS NOT NULL ) );

INSERT INTO Student
	(StdNo, StdFirstName, StdLastName, StdCity,
	 StdState,  StdZip, StdMajor, StdClass, stdGPA)
	VALUES ('123-45-6789','HOMER','WELLS','SEATTLE','WA','98121-1111', 'IS','FR',3.00);


INSERT INTO Student
	(StdNo, StdFirstName, StdLastName, StdCity,
	  StdState,  StdZip, StdMajor, StdClass, stdGPA)
	VALUES ('124-56-7890','BOB','NORBERT','BOTHELL','WA','98011-2121','FIN','JR',2.70);

INSERT INTO Student
	(StdNo, StdFirstName, StdLastName, StdCity,
     StdState,  StdZip, StdMajor, StdClass, stdGPA)
	VALUES ('234-56-7890','CANDY','KENDALL','TACOMA','WA','99042-3321', 'ACCT','JR',3.50);

CREATE TABLE Enrollment (
OfferNo		INTEGER,
StdNo		CHAR(11),
EnrGrade	DECIMAL(3,2),
CONSTRAINT PKEnrollment PRIMARY KEY (OfferNo, StdNo),
CONSTRAINT FKOffering FOREIGN KEY (OfferNo) REFERENCES Offering,
CONSTRAINT FKStudent FOREIGN KEY (StdNo) REFERENCES Student);

--p58
INSERT INTO Offering
	(OfferNo, CourseNo, OffTerm, OffYear, OffLocation, OffTime, FacNo, OffDays)
	VALUES (1234,'IS320','FALL',2019,'BLM302','10:30:00','098-76-5432','MW');

INSERT INTO Offering
	(OfferNo, CourseNo, OffTerm, OffYear, OffLocation, OffTime, FacNo, OffDays)
	VALUES (4321,'IS320','FALL',2019,'BLM214','15:30:00','098-76-5432','TTH');
   

INSERT INTO Enrollment
	(OfferNO, StdNo, EnrGrade)
	VALUES(1234,'123-45-6789',3.30);

INSERT INTO Enrollment
	(OfferNO, StdNo, EnrGrade)
	VALUES(1234,'234-56-7890',3.50);

INSERT INTO Enrollment
	(OfferNO, StdNo, EnrGrade)
	VALUES(4321,'124-56-7890',3.20);

--p58
select facno from faculty;
select stdno from student;
Select distinct facno, stdno from Faculty, Student;
---
--p61

INSERT INTO Enrollment
	(OfferNO, StdNo, EnrGrade)
	VALUES(1234,'123-45-6789',3.30);

INSERT INTO Enrollment
	(OfferNO, StdNo, EnrGrade)
	VALUES(1234,'234-56-7890',3.50);

INSERT INTO Enrollment
	(OfferNO, StdNo, EnrGrade)
	VALUES(4321,'124-56-7890',3.20);

select * from student, Enrollment;
-- p61
select * from student, enrollment 
where student.stdno = enrollment.stdno;

--p62
select * from student full outer join faculty on faculty.facno = student.stdno;

--p62
select * from offering right join faculty on  offering.facno = faculty.facno;

--p63
CREATE TABLE Student2
( StdNo 	    CHAR(11)    CONSTRAINT StdNoRequired NOT NULL,
  StdFirstName  VARCHAR(50) CONSTRAINT StdFirstNameRequired NOT NULL,
  StdLastName   VARCHAR(50) CONSTRAINT StdLastNameRequired NOT NULL,
  StdCity	    VARCHAR(50) CONSTRAINT StdCityRequired NOT NULL,
  StdState	    CHAR(2)	    CONSTRAINT StdStateRequired NOT NULL,
  StdZip	    CHAR(10)    CONSTRAINT StdZipRequired NOT NULL,
  StdMajor	    CHAR(6),
  StdClass	    CHAR(6),
  StdGPA	    DECIMAL(3,2) DEFAULT 0,	
  CONSTRAINT PKStudent2 PRIMARY KEY (StdNo),	
  CONSTRAINT ValidGPA2 CHECK ( StdGPA BETWEEN 0 AND 4 ),
  CONSTRAINT ValidStdClass2 CHECK (StdClass IN ('FR','SO', 'JR','SR')),
  CONSTRAINT MajorDeclared2 CHECK 
               ( StdClass IN ('FR','SO') OR StdMajor IS NOT NULL ) );


INSERT INTO Student2
	(StdNo, StdFirstName, StdLastName, StdCity,
	 StdState,  StdZip, StdMajor, StdClass, stdGPA)
	VALUES ('123-45-6789','HOMER','WELLS','SEATTLE','WA','98121-1111', 'IS','FR',3.00);
INSERT INTO Student2
	(StdNo, StdFirstName, StdLastName, StdCity,
	 StdState, StdMajor, StdClass, StdGPA, StdZip)
	VALUES ('345-67-8901','WALLY','KENDALL','SEATTLE','WA','IS','SR',2.80,'98123-1141');

INSERT INTO Student
	(StdNo, StdFirstName, StdLastName, StdCity,
	 StdState, StdMajor, StdClass, StdGPA, StdZip)
	VALUES ('456-78-9012','JOE','ESTRADA','SEATTLE','WA','FIN','SR',3.20,'98121-2333');

--p64
select * from student;
select * from student2;
Select * from student intersect select * from student2;
Select * from student except select * from student2;
Select * from student2 except select * from student;

--p65
select * from enrollment;
select enrollment.stdno, count(stdno), avg(enrgrade) from enrollment group by stdno;
--p66
select * from enrollment order by offerno, stdno;
select * from student order by stdno;

INSERT INTO Enrollment
	(OfferNO, StdNo, EnrGrade)
	VALUES(1234,'124-56-7890',3.32);

INSERT INTO Enrollment
	(OfferNO, StdNo, EnrGrade)
	VALUES(1234,'456-78-9012',3.22);

select offerNo from enrollment where stdno = all (select stdno from student);
select stdno from student where stdno = all (select stdno from enrollment);
===
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public' -- Replace 'public' with the desired schema name
  AND table_type = 'BASE TABLE';
drop table student2;
drop table enrollment;
drop table offering;
drop table faculty;
drop table student;
drop table course;
