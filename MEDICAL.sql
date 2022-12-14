--CREATION OF THE TABLES
--USING DIFFERENT CONSTRAINTS LIKE PRIMARY KEY,FOREIGN KEY
CREATE TABLE PATIENTS
(PATIENT_ID INT,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
CITY VARCHAR(20),
STATE VARCHAR(20),
GENDER VARCHAR(1)
PRIMARY KEY(PATIENT_ID)
)

CREATE TABLE DOCTORS
(DOCTOR_ID INT PRIMARY KEY,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
PATIENT_ID INT,
FOREIGN KEY(PATIENT_ID) REFERENCES PATIENTS(PATIENT_ID)  ON DELETE SET NULL 
)

CREATE TABLE SALARY
(PATIENT_ID INT,
DOCTOR_ID INT,
SALARY INT,
PRIMARY KEY(PATIENT_ID,DOCTOR_ID),
FOREIGN KEY(PATIENT_ID) REFERENCES PATIENTS(PATIENT_ID) ON DELETE CASCADE,
FOREIGN KEY(DOCTOR_ID) REFERENCES DOCTORS(DOCTOR_ID) ON DELETE CASCADE
)

CREATE TABLE INFO_PATIENTS
(PATIENT_ID INT PRIMARY KEY,
ADMISSION_DATE DATE,
DISCHARGE_DATE DATE,
DIAGONIS VARCHAR(20)
FOREIGN KEY(PATIENT_ID) REFERENCES PATIENTS(PATIENT_ID) 
)

INSERT INTO PATIENTS VALUES
(100,'ROBERT','DOWNEY','KOCHI','KERELA','M'),
(101,'MARTIN','ESUDASS','BANGALORE','KARANATAKA','M'),
(102,'KAMLESH','WARAN','CHENNAI','TAMIL NADU','M'),
(103,'SATISH','KUMAR','CHENNAI','TAMIL NADU','M'),
(104,'TAMIL', 'NITHI','CHENNAI','TAMIL NADU','M'),
(105,'MOHAMED','RIZWANA','KOCHI','KERELA','F'),
(106,'JENNIFER','LOPEZ','KOCHI','KERELA','F'),
(107,'VIJAYA','KUMARI','BANGALORE','KARANTAKA','F'),
(108,'PAWAN','KUMAR','HYDERBAD','ANDHRA PRADESH','M'),
(109,'ANUSHAKA','SHETTY','HYDERBAD','ANDHRA PRADESH','F')



INSERT INTO DOCTORS VALUES
(1001,'DAVID','GODSE',100),
(1002,'DAVID','SAM',101),
(1003,'VINNY','MAC',102),
(1004,'JHON','SAMI',103),
(1005,'MIKE','DANE',104),
(1006,'STEVE','JOBS',105),
(1007,'SHOAIB','IQBAL',106),
(1008,'ALEX','ANNNY',107),
(1009,'CHRIS','MARTIN',108),
(1010,'VINCENT','RAJ',109)

INSERT INTO SALARY VALUES
(100,1001,60000),
(101,1002,65000),
(102,1003,55000),
(103,1004,35000),
(104,1005,40000),
(105,1006,50000),
(106,1007,70000),
(107,1008,75000),
(108,1009,80000),
(109,1010,45000)

INSERT INTO INFO_PATIENTS VALUES
(100,'2022/04/12','2022/06/01','ARITHMIA'),
(101,'2021/01/23','2021/03/11','RBC DEFIENCY'),
(102,'2021/03/22','2021/05/01','LEG FRACTURE'),
(103,'2022/04/17','2022/05/24','EAR OPERATION'),
(104,'2022/04/19','2022/06/30','HAND FRACTURE'),
(105,'2022/02/09','2022/03/13','VIRAL FEVER'),
(106,'2022/06/25','2022/07/11','DENGUE'),
(107,'2022/09/30','2022/10/10','HAEMOGLOBIN DEFIENCY'),
(108,'2021/11/01','2022/11/30','STOMACH ACHES'),
(109,'2021/12/07','2022/02/27','STROKE')

SELECT *
FROM PATIENTS

SELECT * 
FROM DOCTORS

SELECT * 
FROM SALARY 

SELECT *
FROM INFO_PATIENTS

--WHERE,LIKE,IN,AGGREGATE FUNCTIONS
SELECT *
FROM PATIENTS
WHERE CITY='CHENNAI'

SELECT GENDER, COUNT(*) AS TOTAL
FROM PATIENTS
GROUP BY GENDER
ORDER BY GENDER DESC

SELECT FIRST_NAME
FROM PATIENTS
WHERE FIRST_NAME LIKE 'M%'

SELECT FIRST_NAME 
FROM PATIENTS 
WHERE FIRST_NAME LIKE '%E%'

SELECT *
FROM DOCTORS
WHERE PATIENT_ID IN(101,104)

SELECT *
FROM DOCTORS 
WHERE FIRST_NAME='DAVID'
AND PATIENT_ID=101 

SELECT SUM(SALARY) AS TOTAL_SALARY
FROM SALARY


--SUBQUERY 
SELECT *
FROM SALARY
WHERE DOCTOR_ID IN
(SELECT DOCTOR_ID
  FROM SALARY
  WHERE SALARY>55000)

--USE CASE
SELECT DOCTOR_ID,SALARY,
CASE
  WHEN DOCTOR_ID=1001 THEN SALARY+(SALARY+5000)
  WHEN DOCTOR_ID=1001 THEN SALARY+(SALARY+5000)
  ELSE SALARY+(SALARY+10000) 
END AS SALARY_INCREMENT
FROM SALARY

--JOINS
SELECT DOCTORS.DOCTOR_ID,ADMISSION_DATE,DISCHARGE_DATE,DIAGONIS,SALARY
FROM DOCTORS
INNER JOIN INFO_PATIENTS
ON DOCTORS.PATIENT_ID=INFO_PATIENTS.PATIENT_ID
INNER JOIN SALARY
ON INFO_PATIENTS.PATIENT_ID=SALARY.PATIENT_ID

--UNIONS
SELECT PATIENT_ID,FIRST_NAME,LAST_NAME
FROM PATIENTS
UNION
SELECT DOCTOR_ID,FIRST_NAME,LAST_NAME
FROM DOCTORS

--HAVING

SELECT DOCTOR_ID ,COUNT(SALARY)AS TOTAL_SALARY
FROM SALARY
GROUP BY SALARY,DOCTOR_ID
HAVING SALARY>65000
ORDER BY TOTAL_SALARY

--STRING 

SELECT CONCAT(FIRST_NAME ,' ', LAST_NAME) AS FULL_NAME
FROM PATIENTS

SELECT LEFT(FIRST_NAME,3) AS ABBREVATION
FROM PATIENTS

SELECT SUBSTRING(LAST_NAME,1,4)
FROM PATIENTS

--VIEWS
CREATE VIEW [CHENNAI PATIENTS] AS
(SELECT FIRST_NAME,LAST_NAME
FROM PATIENTS
WHERE CITY='CHENNAI')

SELECT * FROM [CHENNAI PATIENTS]

--STORED PROCEDURES

CREATE PROCEDURE ALL_PATIENTS
AS 
SELECT * 
FROM PATIENTS

EXEC ALL_PATIENTS

---THE END ---













