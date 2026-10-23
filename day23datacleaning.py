import pandas as pd

df = pd.read_csv("Sample - Superstore.csv", encoding="latin1")

print("Dataset Loaded Successfully!")
print(df.head())
print(df.shape)
# Display first 5 rows
print("Original Dataset:")
print(df.head())



# Check missing values
print("\nMissing Values in Each Column:")
print(df.isnull().sum())

# Total missing values
print("\nTotal Missing Values:")
print(df.isnull().sum().sum())

# Task completed
print("\nTask 1 Completed!")
# DAY 23 - TASK 2: REMOVE DUPLICATES

# Count rows before removing duplicates
print("\nRows Before Removing Duplicates:")
print(len(df))

# Count duplicate rows
duplicates = df.duplicated().sum()

print("\nNumber of Duplicate Rows:")
print(duplicates)

# Remove duplicate rows
df = df.drop_duplicates()

# Count rows after removing duplicates
print("\nRows After Removing Duplicates:")
print(len(df))

# Display cleaned dataset
print("\nDataset After Removing Duplicates:")
print(df.head())

print("\nTask 2 Completed!")
# DAY 23 - TASK 3: FIX DATA TYPES

# Check data types before cleaning
print("\nData Types Before Cleaning:")
print(df.dtypes)

# Convert Order Date to datetime
df["Order Date"] = pd.to_datetime(
    df["Order Date"], errors="coerce"
)

# Convert numeric columns to proper numeric types
df["Sales"] = pd.to_numeric(
    df["Sales"], errors="coerce"
)

df["Profit"] = pd.to_numeric(
    df["Profit"], errors="coerce"
)

df["Quantity"] = pd.to_numeric(
    df["Quantity"], errors="coerce"
)

df["Discount"] = pd.to_numeric(
    df["Discount"], errors="coerce"
)

# Check data types after cleaning
print("\nData Types After Cleaning:")
print(df.dtypes)

print("\nTask 3 Completed!")
# DAY 23 - TASK 4: CHECK INVALID SALES

# Find records with negative sales
print("\nRecords with Negative Sales:")

invalid_sales = df[df["Sales"] < 0]

print(invalid_sales)

# Count negative sales records
print("\nNumber of Negative Sales Records:")
print(len(invalid_sales))

# Display minimum and maximum sales values
print("\nMinimum Sales Value:")
print(df["Sales"].min())

print("\nMaximum Sales Value:")
print(df["Sales"].max())

print("\nTask 4 Completed!")
# task 5 fix data types
if "Order_Date" in df.columns:
    df["Order_Date"] = pd.to_datetime(
        df["Order_Date"], errors="coerce"
    )


for col in ["Sales", "Profit"]:
    if col in df.columns:
        df[col] = pd.to_numeric(df[col], errors="coerce")

print("\nDataset Data Types:")
print(df.dtypes)
# STEP 6: Validate Dates

if "Order_Date" in df.columns:

    # Check missing dates
    print("\nMissing Dates:")
    print(df["Order_Date"].isnull().sum())

    # Check future dates
    today = pd.Timestamp.today().normalize()

    print("\nFuture Dates:")
    print(df[df["Order_Date"] > today])

    # Check incorrect date formats
    print("\nIncorrect or Invalid Dates:")
    print(df[df["Order_Date"].isnull()])

    # Check duplicate dates
    print("\nDuplicate Dates:")
    print(df[df["Order_Date"].duplicated(keep=False)])

else:
    print("Order_Date column not found!")

print("\nTask 6 Completed!")
# DAY 23 - TASK 7
import pandas as pd
from pathlib import Path

# Get current folder
folder = Path(__file__).parent

# Load dataset
input_file = folder / "Sample - Superstore.csv"

try:
    df = pd.read_csv(input_file, encoding="utf-8")
except FileNotFoundError:
    print("ERROR: Sample - Superstore.csv file not found!")
    print("Keep the CSV file in the same folder as clean_data.py")
    raise SystemExit
except UnicodeDecodeError:
    df = pd.read_csv(input_file, encoding="latin1")

print("Dataset loaded successfully!")
print("Original Shape:", df.shape)

# Remove duplicate rows
df = df.drop_duplicates()

# Standardize text columns
for col in df.select_dtypes(include=["object", "string"]).columns:
    df[col] = df[col].astype("string").str.strip()

# Standardize Category
if "Category" in df.columns:
    df["Category"] = df["Category"].str.title()

# Convert Order Date
if "Order Date" in df.columns:
    df["Order Date"] = pd.to_datetime(
        df["Order Date"], errors="coerce"
    )

# Convert numeric columns
for col in ["Sales", "Profit"]:
    if col in df.columns:
        df[col] = pd.to_numeric(df[col], errors="coerce")

# Save cleaned dataset
output_file = folder / "cleaned_retail_sales.csv"
df.to_csv(output_file, index=False)

print("Cleaning completed successfully!")
print("Cleaned file saved:", output_file)
print("Final Shape:", df.shape)