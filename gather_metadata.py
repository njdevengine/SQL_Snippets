#https://docs.sqlalchemy.org/en/latest/core/engines.html
# SQL Alchemy
import urllib
import sqlalchemy as sa
from sqlalchemy import create_engine
import pandas as pd
#connection+type://user:pass@host/database
engine = create_engine('mysql+pymysql://root:password123@localhost/sakila')
con = engine.connect()

#get tables (might need to do a query "use sakila;" first...)
tables = pd.read_sql("""show tables""",con)

#get tables as array
table_array = list(tables[list(tables)[0]])

#iterate through gathering table names and columns as dataframes
columns = []
for i in table_array:
    query = "SELECT TABLE_NAME,COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'"+i+"'"
    df = pd.read_sql(query,con)
    columns.append(df)
