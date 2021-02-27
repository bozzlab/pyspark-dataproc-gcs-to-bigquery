from pyspark import SparkContext, SparkConf
from pyspark.sql import SparkSession
import pandas as pd
import sys
import os

if len(sys.argv) != 2:
  raise Exception("Arguments Errors")

""" master('local') for local development """

driver_master = os.environ.get("DRIVER","yarn")
dataset = os.environ["DATASET"]
project_id = os.environ["PROJECT_ID"]
table = os.environ["TABLE"]


spark = SparkSession \
  .builder \
  .master() \
  .appName('spark-bigquery-demo') \
  .getOrCreate()

words = spark.read.text(sys.argv[1]).rdd.map(lambda r: r[0])

counts = words.flatMap(lambda line: line.split(" ")) \
              .map(lambda word: (word, 1)) \
              .reduceByKey(lambda x, y: x + y)

rdd_output = counts.collect()

df_data = pd.DataFrame(rdd_output,
                      columns=["word","amount"])

df_data.to_gbq(destination_table = dataset + "." + table, 
              project_id = project_id, 
              if_exists='replace')