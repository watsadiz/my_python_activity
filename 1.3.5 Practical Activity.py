#!/usr/bin/env python
# coding: utf-8

# # Question 1

# Print a specific timestamp: 14:42:05.000566.

# In[ ]:


# import pandas as pd
from datetime import time
t = time(14,42,5,566)

print("Hour", t.hour)
print("Minute", t.minute)
print("Second", t.second)


# # Questions 2

# Print a specific date and timestamp: 2019/01/28 23:55:59.1023

# In[9]:


from datetime import datetime
dt = datetime(2019,1,28,23,55,59,1023)

print("Year", dt.year)
print("Month", dt.month)
print("Date", dt.day)
print("Hour", dt.hour)
print("Minute", dt.minute)
print("Second", dt.second)


# # Question 3

# Print today's date (current day).

# In[22]:


from datetime import date
today = date.today()
print("Year", today.year)
print("Month", today.month)
print("Date", today.day)


# 
# # Question 4

# Print a day from a datetime object: 28 January 2017

# In[29]:


from datetime import datetime
date_string = "28 January 2017"
date_object = datetime.strptime(date_string, "%d %B %Y") 
print("date_object =", date_object) 

day = datetime(2017, 1, 28)
day.strftime('%A')


# # Question 5 

#  The name of the month and day for the ranges of dates between 2008-01-01 and 2008-03-01

# In[38]:


dr = pd.date_range(start = '2008-01-01', end = '2008-03-01')
df = pd.DataFrame()
df['Date'] = dr
df['Week Day'] = pd.to_datetime(dr).weekday
df['Day name'] = pd.to_datetime(dr).strftime('%A')
df['Month'] = pd.to_datetime(dr).strftime('%B')
df


# In[ ]:




