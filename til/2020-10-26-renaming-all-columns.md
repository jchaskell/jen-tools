If you want to rename all columns of a pyspark dataframe using a list:
```
new_df = df.toDF(*new_column_names)
```
