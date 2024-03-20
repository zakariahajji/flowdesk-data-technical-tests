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
    },
    {
        "column1": 20,
        "column2": 2.71,
        "column3": {"nested1": "B", "nested2": {"nested3": False}},
        "column4": ["Z"],
        "column5": datetime.datetime(2023, 2, 1),
    },
    {
        "column1": 30,
        "column2": 1.23,
        "column3": {"nested1": "C", "nested2": {"nested3": True}},
        "column4": ["W", "V"],
        "column5": datetime.datetime(2023, 3, 1),
    },
]
df = pd.DataFrame(data)
print(f"Pandas dataframe  : {df}")
print(f"Pandas Types : \n{df.dtypes}")


def generate_bigquery_schema_from_pandas(df: pd.DataFrame) -> list[dict]:

    type_mapping = {
        "int64": "INTEGER",  # in test data
        "float64": "FLOAT",  # in test data
        "object": "STRING",  # in test data
        "datetime64[ns]": "DATETIME",  # in test data
        "bool": "BOOLEAN",  # added for robustness
    }
    schema = []

    # Getting the list of types :
    list_of_types = df.dtypes.items()

    # Building Schema
    for column_name, its_type in list_of_types:
        bigquery_type = type_mapping.get(
            str(its_type), "STRING"
        )  # Defaulting to string if the type does not match the mapping

        schema.append({"name": column_name, "type": bigquery_type})

    return schema


print(generate_bigquery_schema_from_pandas(df))
