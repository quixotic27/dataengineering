from pyspark.sql import SparkSession
from pyspark.sql.functions import col, lit, rand

# Initialize Spark session
spark = SparkSession.builder.appName("SaltingExample").getOrCreate()

# Sample data
data1 = [(1, "Alice", 2000),
         (2, "Bob", 1500),
         (2, "Charlie", 1600),
         (3, "David", 1300),
         (3, "Eve", 1400),
         (4, "Frank", 1200)]

data2 = [(1, "HR"),
         (2, "IT"),
         (3, "Sales"),
         (4, "Finance")]

# Create DataFrames
df1 = spark.createDataFrame(data1, ["id", "name", "salary"])
df2 = spark.createDataFrame(data2, ["id", "department"])

# Show the DataFrames
df1.show()
df2.show()
df_salt1 = df1.withColumn("salt", (rand()*10+1).cast("int"))
display(df_salt1)
df_salt1_trans = df_salt1.withColumn("salted_key", concat(col("id"),lit('-'), col("salt")))
display(df_salt1_trans)

df_salt2 = df2.withColumn("salt", array([lit(i) for i in range (1,11)]))
display(df_salt2)
df_explode = df_salt2.withColumn("salt", explode("salt"))
display(df_explode)

df_concat  = df_explode.withColumn("salted_key", concat(col("id"),lit('-'), col("salt")))
display(df_concat)

df_join = df_salt1_trans.join(df_concat, ["salted_key"],"inner")
display(df_join)

#drop salt keys later
df_final  = df_join.drop("salted_key","salt")
df_final.display()
