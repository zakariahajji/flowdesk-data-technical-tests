"""Module that contains a Pandas to BigQuery schema translator."""

import datetime
import pandas as pd

data = [
    {
        "column1": 10,
        "column2": 3.14,
        "column3": {"nested1": "A", "nested2": {"nested3": True}},
        "column4": ["X", "Y"],
        "column5": datetime.datetime(2023, 1, 1),
        "column_string": "my_string",
    },
    {
        "column1": 20,
        "column2": 2.71,
        "column3": {"nested1": "B", "nested2": {"nested3": False}},
        "column4": ["Z"],
        "column5": datetime.datetime(2023, 2, 1),
        "column_timestamp_in_a_different_place_to_check": datetime.datetime(2023, 1, 1),
        "nested_column_timestamp": {
            "nested1": {"nested_time": datetime.datetime(2024, 1, 1)}
        },
    },
    {
        "column1": 30,
        "column2": 1.23,
        "column3": {"nested1": "C", "nested2": {"nested3": True}},
        "column4": ["W", "V"],
        "column5": datetime.datetime(2023, 3, 1),
        "column_bool": False,
    },
]
df = pd.DataFrame(data)
print(f"Pandas dataframe  : {df}")
print(f"Pandas Types : \n{df.dtypes}")


"""
Notes :

Pandas columns can correspond to either an  ( int, float, bool ) : I will map these

take care of the dict and lists seperatly.

booleans ended up being a special type because they are infered as objects in pandas's dtypes, they need to be got out of their context. 

datetimes in nested fields ended up handled seperatly aswell like booleans

"""


def is_nested_dict(df: pd.DataFrame, column_name: str):
    """Check if dictionaries"""
    if df[column_name].apply(lambda x: isinstance(x, dict)).any():
        return True
    return False


def is_list(df: pd.DataFrame, column_name: str):
    """Check if lists"""
    if df[column_name].apply(lambda x: isinstance(x, list)).any():
        return True
    return False


def is_boolean(df: pd.DataFrame, column_name: str):
    """Check if a column contains exclusively boolean values."""
    if df[column_name].apply(lambda x: isinstance(x, bool)).any():
        return True
    return False


def generate_schema_for_nested_dict(nested_dict: dict):
    """Recursively generate schema for dictionaries"""
    schema = []
    for key, value in nested_dict.items():
        field = {"name": key, "type": "STRING", "mode": "NULLABLE"}
        if isinstance(value, dict):
            field["type"] = "RECORD"
            field["fields"] = generate_schema_for_nested_dict(value)
        elif isinstance(value, bool):
            field["type"] = "BOOLEAN"
        elif isinstance(value, datetime.datetime):
            field["type"] = "TIMESTAMP"

        schema.append(field)
    return schema


def generate_bigquery_schema_from_pandas(df: pd.DataFrame):
    """Generate a BigQuery schema from a pandas DataFrame."""
    if not isinstance(df, pd.DataFrame):
        raise ValueError("Input must be a pandas datarame")

    if df.empty:
        print("df is empty. returning an empty schema.")
        return {}

    type_mapping = {
        "int64": "INTEGER",
        "float64": "FLOAT",
        "datetime64[ns]": "TIMESTAMP",
    }

    schema = {}
    for column_name in df.columns:  # for each isolated column ( nested or not)
        try:
            column_schema = {"type": "STRING", "mode": "NULLABLE"}  # set a default type

            if is_boolean(df, column_name):
                column_schema = {"type": "BOOLEAN", "mode": "NULLABLE"}
            elif is_list(df, column_name):
                column_schema = {"type": "STRING", "mode": "REPEATED"}
            elif is_nested_dict(df, column_name):
                non_na_items = df[column_name].dropna()
                if not non_na_items.empty:
                    first_non_na_item = non_na_items.iloc[
                        0
                    ]  # Generating type for the first non na item
                    fields = generate_schema_for_nested_dict(
                        first_non_na_item
                    )  # this assumes that the structure of encountered items should have the same structure ( by enforcing schema in the dataframe for example)
                    column_schema = {
                        "type": "RECORD",
                        "mode": "NULLABLE",
                        "fields": fields,
                    }
            else:
                pandas_dtype = df[column_name].dtype
                bigquery_type = type_mapping.get(str(pandas_dtype), "STRING")
                column_schema = {"type": bigquery_type, "mode": "NULLABLE"}

            schema[column_name] = column_schema

        except Exception as e:
            print(f"Error handling col {column_name}: {e}. This col will be skipped.")

    return schema


print(generate_bigquery_schema_from_pandas(df))
print(type(generate_bigquery_schema_from_pandas(df)))  # dict
