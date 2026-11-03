# ==========================================
# EMPLOYEE ATTRITION PROJECT
# PHASE 2: IMPORT DATA INTO MYSQL
# ==========================================

import pandas as pd

from pathlib import Path
from getpass import getpass

from sqlalchemy import create_engine, URL, text


# ==========================================
# 1. PROJECT PATH
# ==========================================

PROJECT_DIR = Path(__file__).resolve().parent.parent

DATA_PATH = (
    PROJECT_DIR
    / "data"
    / "processed"
    / "employee_attrition_with_id.csv"
)


# ==========================================
# 2. LOAD DATA
# ==========================================

df = pd.read_csv(DATA_PATH)

print("Dataset loaded successfully!")

print("Total Employees:", len(df))


# ==========================================
# 3. VALIDATE EMPLOYEE ID
# ==========================================

if "EmployeeID" not in df.columns:
    raise ValueError("EmployeeID column not found!")

if df["EmployeeID"].isnull().any():
    raise ValueError("EmployeeID contains missing values!")

if df["EmployeeID"].duplicated().any():
    raise ValueError("Duplicate EmployeeID found!")

df["EmployeeID"] = df["EmployeeID"].astype(int)


# ==========================================
# 4. MYSQL CONNECTION
# ==========================================

password = input("Enter MySQL root password: ")

connection_url = URL.create(
    drivername="mysql+pymysql",
    username="root",
    password=password ,
    host="localhost",
    port=3306,
    database="employee_attrition"
)

engine = create_engine(connection_url)


# ==========================================
# 5. TEST MYSQL CONNECTION
# ==========================================

with engine.connect() as connection:

    result = connection.execute(
        text("SELECT DATABASE()")
    )

    print("Connected Database:", result.scalar())


# ==========================================
# 6. CREATE DEPARTMENT TABLE DATA
# ==========================================

department_mapping = {
    "Sales": 1,
    "Research & Development": 2,
    "Human Resources": 3
}

df["DepartmentID"] = df["Department"].map(
    department_mapping
)

if df["DepartmentID"].isnull().any():
    raise ValueError("Unknown department found!")

departments = pd.DataFrame({
    "DepartmentID": list(department_mapping.values()),
    "DepartmentName": list(department_mapping.keys())
})


# ==========================================
# 7. PREPARE EMPLOYEE TABLE
# ==========================================

employees = df[[
    "EmployeeID",
    "Age",
    "Gender",
    "MaritalStatus",
    "Education",
    "EducationField",
    "DepartmentID",
    "JobRole",
    "JobLevel",
    "Attrition",
    "NumCompaniesWorked",
    "TotalWorkingYears",
    "YearsAtCompany",
    "YearsInCurrentRole",
    "YearsWithCurrManager"
]].copy()


# ==========================================
# 8. PREPARE SALARIES TABLE
# ==========================================

salaries = df[[
    "EmployeeID",
    "DailyRate",
    "HourlyRate",
    "MonthlyIncome",
    "MonthlyRate",
    "PercentSalaryHike",
    "StockOptionLevel"
]].copy()


# ==========================================
# 9. PREPARE ATTENDANCE TABLE
# ==========================================

attendance = df[[
    "EmployeeID",
    "BusinessTravel",
    "OverTime",
    "DistanceFromHome"
]].copy()


# ==========================================
# 10. PREPARE PERFORMANCE TABLE
# ==========================================

performance = df[[
    "EmployeeID",
    "EnvironmentSatisfaction",
    "JobInvolvement",
    "JobSatisfaction",
    "PerformanceRating",
    "RelationshipSatisfaction",
    "WorkLifeBalance",
    "TrainingTimesLastYear",
    "YearsSinceLastPromotion"
]].copy()


# ==========================================
# 11. INSERT DATA INTO MYSQL
# ==========================================

try:

    with engine.begin() as connection:

        # Clear old data in child-to-parent order
        # so the script can safely be rerun.

        connection.execute(
            text("DELETE FROM performance")
        )

        connection.execute(
            text("DELETE FROM attendance")
        )

        connection.execute(
            text("DELETE FROM salaries")
        )

        connection.execute(
            text("DELETE FROM employees")
        )

        connection.execute(
            text("DELETE FROM departments")
        )

        # Insert departments first

        departments.to_sql(
            "departments",
            con=connection,
            if_exists="append",
            index=False
        )

        # Insert employees

        employees.to_sql(
            "employees",
            con=connection,
            if_exists="append",
            index=False,
            chunksize=500
        )

        # Insert salaries

        salaries.to_sql(
            "salaries",
            con=connection,
            if_exists="append",
            index=False,
            chunksize=500
        )

        # Insert attendance

        attendance.to_sql(
            "attendance",
            con=connection,
            if_exists="append",
            index=False,
            chunksize=500
        )

        # Insert performance

        performance.to_sql(
            "performance",
            con=connection,
            if_exists="append",
            index=False,
            chunksize=500
        )

    print("\nAll records inserted successfully!")

except Exception as error:

    print("\nDatabase import failed!")
    print("Error:", error)

    raise

finally:

    engine.dispose()


# ==========================================
# 12. FINAL SUMMARY
# ==========================================

print("\n========== IMPORT SUMMARY ==========")

print("Departments:", len(departments))
print("Employees:", len(employees))
print("Salaries:", len(salaries))
print("Attendance:", len(attendance))
print("Performance:", len(performance))

print("\nMYSQL DATA IMPORT COMPLETED!")