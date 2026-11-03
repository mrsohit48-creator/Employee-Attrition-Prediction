
import sys
from pathlib import Path

import joblib
import pandas as pd
import numpy as np


# ---------------------------------------
# 1. PROJECT PATHS
# ---------------------------------------

PROJECT_ROOT = Path(__file__).resolve().parent.parent

MODEL_PATH = (
    PROJECT_ROOT
    / "models"
    / "best_attrition_model.pkl"
)


# ---------------------------------------
# 2. PREDICTION FUNCTION
# ---------------------------------------

def predict_employee_attrition(input_file):

    # Check whether model exists
    if not MODEL_PATH.exists():
        raise FileNotFoundError(
            "Model not found. Run the machine learning notebook first."
        )

    # Load trained model
    model = joblib.load(MODEL_PATH)

    # Read employee data
    input_path = Path(input_file)

    if not input_path.is_absolute():
        input_path = PROJECT_ROOT / input_path

    if not input_path.exists():
        raise FileNotFoundError(
            f"Input CSV not found: {input_path}"
        )

    employee_data = pd.read_csv(input_path)

    # ---------------------------------------
    # VALIDATE AND COMPLETE INPUT COLUMNS
    # ---------------------------------------

    expected_columns = (
        model.named_steps["preprocessor"].feature_names_in_
    )

    # Add constant columns that are not supplied
    default_values = {
        "EmployeeCount": 1,
        "Over18": "Y",
        "StandardHours": 80
    }

    for column, value in default_values.items():
        if column in expected_columns and column not in employee_data.columns:
            employee_data[column] = value

    # Check remaining missing columns
    missing_columns = [
        column for column in expected_columns
        if column not in employee_data.columns
    ]

    if missing_columns:
        raise ValueError(
            f"Missing required columns: {missing_columns}"
        )

    # Keep exactly the columns used during training, in their original order
    features = employee_data[expected_columns].copy()

    # Preserve EmployeeID
    if "EmployeeID" in employee_data.columns:
        employee_ids = employee_data["EmployeeID"].copy()
    else:
        employee_ids = pd.Series(
            range(1, len(employee_data) + 1),
            name="EmployeeID"
        )

    # Generate predictions
    predictions = model.predict(features)

    probabilities = model.predict_proba(features)[:, 1]

    # Create prediction report
    results = pd.DataFrame({
        "EmployeeID": employee_ids,
        "Predicted_Attrition": np.where(
            predictions == 1, "Yes", "No"
        ),
        "Attrition_Probability": probabilities
    })

    # Save report
    output_file = (
        PROJECT_ROOT
        / "reports"
        / "new_employee_predictions.csv"
    )

    output_file.parent.mkdir(
        parents=True,
        exist_ok=True
    )

    results.to_csv(output_file, index=False)

    # Display results
    print("\nEMPLOYEE ATTRITION PREDICTION")
    print("----------------------------------")

    print(results.to_string(index=False))

    print("\nPrediction completed successfully!")
    print("Saved report:", output_file)


# ---------------------------------------
# 3. RUN FROM TERMINAL
# ---------------------------------------

if __name__ == "__main__":

    if len(sys.argv) != 2:
        print(
            "Usage: python src/predict.py "
            "path_to_employee_data.csv"
        )
        sys.exit(1)

    predict_employee_attrition(sys.argv[1])
