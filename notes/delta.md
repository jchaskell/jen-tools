# Delta
Notes on [delta lakes](https://docs.delta.io/latest/index.html).

Basic functions for reading and writing:

``
`spark.read.format("delta").load("path")
df.write.format("delta").mode("overwrite").save("path")
df.write.format("delta").partitionBy("col_a").saveAsTable("mytable")``

Mode options: overwrite, append
If you write to a table/location that already exists, the schema needs to match

### Updating tables
Condition update: `table.update(condition = expr("id % s == 0"), set = { "id":
expr("id + 100") }`
Updates even values by adding 100

Delete based on condition (even value): `table.delete(condition = expr("id % 2 == 0"))`

Upsert:
```hiddijhkl;dd
df.alias('olddata').merge(newdata.alias('newdata'), "olddata.id = newdata.id")
\
.whenMatchedUpdate(set = { "id": col("newdata.id") }) \
.whenNotMatchedInsert(values = { "id": col("newdata.id") }) \
.execute()
```
Replace given conditions: `.option("replaceWhere", "date >= '2017-01-01'")`

[This](https://docs.delta.io/latest/delta-update.html) page
has examples of update queries. Merges can be made faster by adding conditions,
not having too many small files, controlling the shuffle partitions, and
repartitioning the output before writing.


### Time travel
Read old versions of data: `spark.read.format("delta").option("versionAsOf", 0)`
Can use "versionAsOf" or "timestampAsOf" in option - need either a version
number of a timestamp string (instead of a timestamp string, you can use a date
"2019-01-01")

To use the latest version:
``latest_version = spark.sql("select max(version) from describe history delta
`/delta/events`)").collect()
df = spark.read.format("delta").option("versionAsOf",
latest_version[0][0]).load("/delta/events")```
`
By default, delta keeps versions for the last 30 days, but if you run vacuum
you lose that

### Schema
It automatically checks the schema for you. Can update it with DDL. If there is
partitioning, those partitions are maintained with updates.

The link includes information on how to change the schema, including column
type, name, etc. 

### Streaming
``
```streamingdf = spark.readStream.format("rate").load()
stream = streamingdf.selectExpr("value as id").writeStream.format("delta") \
    .option("checkpointLocation", "path").start("final_path")
stream.stop() # to stop the stream``
More info on structured streaming (here)[https://docs.delta.io/latest/delta-streaming.html]

### Spark
You need to configure your spark session with:
``from pyspark.sql import SparkSession

spark = SparkSession \
  .builder \
  .appName("...") \
  .master("...") \
  .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension") \
  .config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog") \
  .getOrCreate()``

