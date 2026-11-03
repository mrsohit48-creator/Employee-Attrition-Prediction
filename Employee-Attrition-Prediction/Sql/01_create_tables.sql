-- ==========================================
-- EMPLOYEE ATTRITION PREDICTION PROJECT
-- PHASE 2: DATABASE CREATION
-- ==========================================

-- Create database

CREATE DATABASE IF NOT EXISTS employee_attrition;

USE employee_attrition;


-- ==========================================
-- TABLE 1: DEPARTMENTS
-- ==========================================

CREATE TABLE IF NOT EXISTS departments (

    DepartmentID INT PRIMARY KEY,

    DepartmentName VARCHAR(100) NOT NULL UNIQUE

);


-- ==========================================
-- TABLE 2: EMPLOYEES
-- ==========================================

CREATE TABLE IF NOT EXISTS employees (

    EmployeeID INT PRIMARY KEY,

    Age INT,

    Gender VARCHAR(20),

    MaritalStatus VARCHAR(30),

    Education INT,

    EducationField VARCHAR(100),

    DepartmentID INT,

    JobRole VARCHAR(100),

    JobLevel INT,

    Attrition VARCHAR(10),

    NumCompaniesWorked INT,

    TotalWorkingYears INT,

    YearsAtCompany INT,

    YearsInCurrentRole INT,

    YearsWithCurrManager INT,

    FOREIGN KEY (DepartmentID)
        REFERENCES departments(DepartmentID)

);


-- ==========================================
-- TABLE 3: SALARIES
-- ==========================================

CREATE TABLE IF NOT EXISTS salaries (

    EmployeeID INT PRIMARY KEY,

    DailyRate DECIMAL(12,2),

    HourlyRate DECIMAL(10,2),

    MonthlyIncome DECIMAL(12,2),

    MonthlyRate DECIMAL(12,2),

    PercentSalaryHike INT,

    StockOptionLevel INT,

    FOREIGN KEY (EmployeeID)
        REFERENCES employees(EmployeeID)

);


-- ==========================================
-- TABLE 4: ATTENDANCE
-- ==========================================

CREATE TABLE IF NOT EXISTS attendance (

    EmployeeID INT PRIMARY KEY,

    BusinessTravel VARCHAR(50),

    OverTime VARCHAR(10),

    DistanceFromHome INT,

    FOREIGN KEY (EmployeeID)
        REFERENCES employees(EmployeeID)

);


-- ==========================================
-- TABLE 5: PERFORMANCE
-- ==========================================

CREATE TABLE IF NOT EXISTS performance (

    EmployeeID INT PRIMARY KEY,

    EnvironmentSatisfaction INT,

    JobInvolvement INT,

    JobSatisfaction INT,

    PerformanceRating INT,

    RelationshipSatisfaction INT,

    WorkLifeBalance INT,

    TrainingTimesLastYear INT,

    YearsSinceLastPromotion INT,

    FOREIGN KEY (EmployeeID)
        REFERENCES employees(EmployeeID)

);


-- ==========================================
-- VERIFY TABLE CREATION
-- ==========================================

SHOW TABLES;