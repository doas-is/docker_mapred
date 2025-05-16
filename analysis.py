from pyspark.sql import SparkSession
from pyspark.sql.functions import col, sum, count, desc
from pyspark.sql.types import StructType, StructField, StringType, DoubleType

spark = SparkSession.builder \
    .appName("PurchaseAnalysis") \
    .getOrCreate()

# schema definition(tab-delimited, no header)
schema = StructType([
    StructField("date", StringType(), True),
    StructField("time", StringType(), True),
    StructField("city", StringType(), True),
    StructField("category", StringType(), True),
    StructField("price", DoubleType(), True),
    StructField("payment_method", StringType(), True)
])
df = spark.read.csv(
    "purchases.csv",
    sep="\t",
    header=False,
    schema=schema
)

#print schema
print("Schema:")
df.printSchema()

# Basic statistics for price
print("\nPrice Statistics:")
df.describe(["price"]).show()

#total Revenue (sum of all prices)
total_revenue = df.agg(sum("price").alias("total_revenue"))
print("\nTotal Revenue:")
total_revenue.show()

# top Cities by revenue
city_revenue = df.groupBy("city") \
    .agg(sum("price").alias("total_revenue")) \
    .orderBy(desc("total_revenue"))

print("\nTop 10 Cities by Revenue:")
city_revenue.show(10, truncate=False)

#top Product Categories by Revenue and Transaction Count
category_stats = df.groupBy("category") \
    .agg(
        count("*").alias("transaction_count"),
        sum("price").alias("total_revenue")
    ) \
    .orderBy(desc("total_revenue"))

print("\nTop 10 Product Categories:")
category_stats.show(10, truncate=False)

#payment method
payment_stats = df.groupBy("payment_method") \
    .agg(
        count("*").alias("transaction_count"),
        sum("price").alias("total_revenue")
    ) \
    .orderBy(desc("total_revenue"))

print("\nPayment Method Breakdown:")
payment_stats.show(truncate=False)

#daily Sales Trend
daily_sales = df.groupBy("date") \
    .agg(sum("price").alias("daily_revenue")) \
    .orderBy("date")

print("\nDaily Sales Trend:")
daily_sales.show(truncate=False)

#hourly sales (combine date + time)
from pyspark.sql.functions import to_timestamp, hour
df_with_hour = df.withColumn(
    "timestamp",
    to_timestamp(col("date") + " " + col("time"), "yyyy-MM-dd HH:mm")
).withColumn("hour", hour("timestamp"))

hourly_sales = df_with_hour.groupBy("hour") \
    .agg(sum("price").alias("hourly_revenue")) \
    .orderBy("hour")

# Stop Spark session
spark.stop()