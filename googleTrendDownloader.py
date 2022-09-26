'''
Python script to retrieve google trends data from all 50 states for given keywords in CSV format

adapted from:
    https://www.honchosearch.com/blog/seo/how-to-use-python-pytrends-to-automate-google-trends-data/
    Requires pytrends and pandas libraries

modified by Reginald Hebert
version 2022-09-24

Note:
    First, create a file called keyword_list.csv, with the A1 column headed by the word "Keywords"
    with keywords in subsequent rows.

    Regarding time range, google only provides daily data up to 90 days and weekly up to 60 months,
    with monthly aggregates thereafter.

    Date range must be in the format of start - end:
        YYYY-MM-DD YYYY-MM-DD
        e.g. 2017-03-01 2017-07-28

    To use a topic rather than a term, first search the term and get the topic. Then get the URL.
    Extract everything after the "q=" portion.
    e.g. "hearing aid" as a topic is /m/02kzw4, but the URL is %2Fm%2F02kzw4
    The %2F is hex code for /
'''


from pytrends.request import TrendReq
import pandas as pd
import time
startTime = time.time()
pytrend = TrendReq(hl='en-US', tz=360)

colnames = ["keywords"]
df = pd.read_csv("keyword_list.csv", names=colnames)
df2 = df["keywords"].values.tolist()
df2.remove("Keywords")

# temporarily using topic rather than term
# hearing aid topic = "/m/02kzw4" entered as keyword in CSV

dataset = []

# Enter time frame here
time_range = '2019-12-29 2022-09-25'

# time_range = '2017-01-01 2019-12-28'

state_list = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL",
              "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA",
              "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE",
              "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK",
              "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT",
              "VA", "WA", "WV", "WI", "WY", "DC"]

# state_list = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL"]
#
# state_list = ["GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA"]
#
# state_list = ["ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE"]
#
# state_list = ["NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK"]
#
# state_list = ["OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT"]
#
# state_list = ["VA", "WA", "WV", "WI", "WY", "DC"]



for x in range(0,len(df2)):
     keywords = [df2[x]]
     for y in range(0,len(state_list)) :
         pytrend.build_payload(
         kw_list=keywords,
         cat=0,
         timeframe=time_range,
         geo='US-'+state_list[y])

         time.sleep(min((y+1),20)) # used to avoid 429 error from google

         data = pytrend.interest_over_time()
         if not data.empty:
              data = data.drop(labels=['isPartial'],axis='columns')
              data.rename(columns={df2[x]:df2[x]+'_'+state_list[y]}, inplace = True)
              dataset.append(data)

result = pd.concat(dataset, axis=1)
result.to_csv('search_trends.csv')

executionTime = (time.time() - startTime)
print('Execution time in sec.: ' + str(executionTime))