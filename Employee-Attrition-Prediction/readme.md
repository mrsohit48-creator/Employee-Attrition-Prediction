# Employee Attrition Analysis & Prediction

## Project Overview

Employee Attrition Analysis & Prediction is an end-to-end Data Analytics and Machine Learning project designed to analyze employee turnover and identify factors associated with employee attrition.

The project uses Python for data cleaning, exploratory data analysis (EDA), and machine learning; MySQL for structured data storage and SQL analysis; and Power BI for interactive HR dashboards.

The machine learning component uses Logistic Regression and Random Forest to estimate employee attrition probability and classify employees into different risk categories.

The objective is to help HR teams understand employee turnover patterns, explore workforce trends, and make more informed employee-retention decisions.

---

## Project Objectives

- Analyze employee attrition patterns.
- Identify factors associated with employee turnover.
- Clean and prepare employee HR data.
- Store structured employee information in MySQL.
- Perform exploratory data analysis using Python.
- Build machine learning models to predict employee attrition.
- Compare Logistic Regression and Random Forest performance.
- Develop interactive HR dashboards using Power BI.
- Generate employee-level attrition predictions.

---

## Technologies Used

| Technology | Purpose |
|---|---|
| Python | Data analysis and machine learning |
| Pandas | Data manipulation and cleaning |
| NumPy | Numerical operations |
| Matplotlib | Data visualization |
| Seaborn | Statistical visualization |
| Scikit-learn | Machine learning |
| Joblib | Model serialization |
| MySQL | Database management |
| SQLAlchemy | Python–MySQL connection |
| PyMySQL | MySQL connectivity |
| Power BI | Interactive dashboards |
| Excel / CSV | Data storage |
| Git & GitHub | Version control |

---

## Dataset Information

**Dataset:** IBM HR Analytics Employee Attrition & Performance

**Source:** Kaggle

Dataset link: https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset

| Dataset Property | Details |
|---|---|
| Total Records | 1,470 |
| Total Original Columns | 35 |
| Target Variable | Attrition |
| Target Classes | Yes / No |
| Employees Who Stayed | 1,233 |
| Employees Who Left | 237 |
| Overall Attrition Rate | 16.12% |

The dataset contains employee demographics, job information, salary details, work experience, job satisfaction, and work-life balance information.

**Target Variable:**
- Yes: Employee left the organization.
- No: Employee stayed with the organization.

Note: The dataset is a historical IBM HR sample dataset and does not represent a live company's workforce.

---

## Project Workflow

### Phase 1: Data Collection

- Imported the IBM HR Analytics dataset.
- Inspected rows, columns, and data types.
- Checked missing values and duplicate records.
- Renamed EmployeeNumber to EmployeeID.
- Identified constant columns.
- Saved the processed dataset.

### Phase 2: MySQL Database Management

Created a MySQL database named `employee_attrition`.

Database tables:

- departments
- employees
- salaries
- attendance
- performance

Used Python, SQLAlchemy, and PyMySQL to import employee data into MySQL.

Note: The attendance table contains available work-pattern information, such as overtime and business travel, rather than actual daily attendance logs.

### Phase 3: Data Cleaning & Exploratory Data Analysis

Performed data cleaning using Pandas.

Analysis included:

- Missing-value analysis.
- Duplicate-record analysis.
- Employee attrition distribution.
- Department-wise attrition.
- Overtime and attrition analysis.
- Job satisfaction analysis.
- Age and salary distribution.
- Correlation analysis.
- Business insights generation.

### Phase 4: Machine Learning

Developed two machine learning models:

**1. Logistic Regression**
- Used as a classification baseline.
- Applied class balancing.
- Evaluated classification performance.

**2. Random Forest Classifier**
- Used multiple decision trees.
- Applied class balancing.
- Evaluated classification performance.

Model evaluation metrics:

- Accuracy
- Precision
- Recall
- F1-score
- ROC-AUC

Selected the best-performing model based on F1-score and saved the complete preprocessing and prediction pipeline using Joblib.

### Phase 5: Power BI Dashboard

Created a four-page interactive HR analytics dashboard.

**Page 1 – HR Overview**
- Total Employees
- Employees Left
- Attrition Rate
- Average Age
- Department-wise Attrition
- Overtime Analysis
- Age Group Analysis
- Gender Analysis

**Page 2 – Department & Job Role Analysis**
- Department Attrition Rate
- Job Role-wise Attrition
- Job Satisfaction
- Average Monthly Income
- Department Performance Summary

**Page 3 – Employee Demographics & Satisfaction**
- Age Group Analysis
- Gender Analysis
- Education Field Analysis
- Work-Life Balance
- Experience Group Analysis
- Job Satisfaction

**Page 4 – Attrition Risk & ML Predictions**
- Predicted Attrition Cases
- High, Medium, and Low Risk Categories
- Average Attrition Probability
- Employee-wise Risk Table
- Prediction Distribution

The fourth page uses predictions generated by the saved machine learning pipeline when the prediction CSV is available.

---

## Machine Learning Methodology

### Data Preprocessing

- Separated features and target variable.
- Removed EmployeeID from model features.
- Converted categorical variables using OneHotEncoder.
- Scaled numerical features using StandardScaler.
- Used SimpleImputer for missing-value handling.
- Applied stratified train-test splitting.

### Train-Test Split

| Dataset | Percentage |
|---|---:|
| Training Data | 80% |
| Testing Data | 20% |

Random state: 42

### Model Evaluation

The models were evaluated using Accuracy, Precision, Recall, F1-score, and ROC-AUC.

Actual model performance values are recorded in:

`reports/model_comparison.csv`

No model accuracy or performance result is assumed in this README; the final figures should be updated using the actual experiment results.

---

## Project Folder Structure

```text
Employee-Attrition-Prediction/
│
├── data/
│   ├── raw/
│   ├── processed/
│   │   ├── employee_attrition_with_id.csv
│   │   └── employee_attrition_cleaned.csv
│   └── new_employees/
│       └── new_employees.csv
│
├── notebooks/
│   ├── 01_Data_Collection.ipynb
│   ├── 02_Data_Cleaning_EDA.ipynb
│   └── 03_Machine_Learning.ipynb
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── Insert_data.py
│   └── 03_analysis_queries.sql
│
├── src/
│   └── predict.py
│
├── models/
│   └── best_attrition_model.pkl
│
├── powerbi/
│   └── Employee_Attrition_Dashboard.pbix
│
├── reports/
│   ├── data_quality_report.csv
│   ├── data_quality_report_phase3.csv
│   ├── eda_insights.txt
│   ├── model_comparison.csv
│   ├── employee_predictions.csv
│   ├── new_employee_predictions.csv
│   └── Employee_Attrition_Dashboard.pdf
│
├── images/
│   ├── model_comparison.png
│   ├── confusion_matrices.png
│   └── roc_curve_comparison.png
│
├── README.md
└── requirements.txt
```

Only include files that actually exist in your repository.

---

## How to Run the Project

### 1. Clone the Repository

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
```

### 2. Open the Project

```bash
cd Employee-Attrition-Prediction
```

### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

### 4. Run the Jupyter Notebooks

Run the notebooks in this order:

1. `01_Data_Collection.ipynb`
2. `02_Data_Cleaning_EDA.ipynb`
3. `03_Machine_Learning.ipynb`

### 5. Configure MySQL

- Create the `employee_attrition` database.
- Execute `sql/01_create_tables.sql`.
- Configure your local database connection securely.
- Run `sql/Insert_data.py`.

### 6. Generate Employee Predictions

After training and saving the model, run:

```bash
python src/predict.py "data/new_employees/new_employees.csv"
```

The generated prediction file is saved as:

```text
reports/new_employee_predictions.csv
```

### 7. Open the Power BI Dashboard

Open:

```text
powerbi/Employee_Attrition_Dashboard.pbix
```

Refresh the data sources if required.

---

## Key Business Questions

This project explores the following HR questions:

1. What percentage of employees leave the organization?
2. Which departments experience higher attrition?
3. Is overtime associated with employee turnover?
4. How does job satisfaction relate to attrition?
5. How does monthly income differ between employees who stay and leave?
6. Which age groups have higher employee turnover?
7. How does work-life balance relate to attrition?
8. Can machine learning estimate employee attrition probability?

---

## Business Value

The analysis can help HR teams:

- Understand employee turnover patterns.
- Identify departments requiring further investigation.
- Explore employee satisfaction and work-life balance.
- Examine compensation and overtime patterns.
- Prioritize employee-retention discussions using model estimates.
- Make data-informed workforce planning decisions.

Machine learning predictions are estimates, not confirmed future departures. They should be validated and used responsibly, never as the sole basis for employment decisions.

---

## Future Improvements

- Hyperparameter tuning and threshold optimization.
- Cross-validation and improved model evaluation.
- SHAP-based model explainability.
- More detailed employee retention analysis.
- Automated Power BI data refresh.
- Interactive prediction application using Streamlit.
- Additional employee-level risk explanations.

---

## Author

**Mayank Gupta**

Aspiring Data Analyst | Python | SQL | Power BI | Excel | Machine Learning

**LinkedIn:** https://linkedin.com/in/mayank-gupta-89a893352

**GitHub:** https://github.com/Dev-Mayank70

---

## Acknowledgements

- IBM HR Analytics Employee Attrition & Performance Dataset.
- Kaggle for dataset availability.
- Python and open-source data analytics libraries.
- Microsoft Power BI for dashboard development.

---

*This project was developed for learning, practical data analytics experience, and portfolio demonstration.*