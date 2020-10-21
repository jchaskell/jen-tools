This includes the format for Spark schema (in pyspark) which I did not learn
today but always forget. It also includes how to write that schema to a json
file.

``
import json
from pyspark.sql.types import StructType, StructField, LongType, IntegerType
schema = StructType([StructField('id', IntegerType()),
                     StructField('cost', LongType())])
with open('file.json', 'w') as f:
    json.dump(schema.jsonValue(), f)
            ```
