
# coding: utf-8

# # 24 November 2017

# # Merging, Joining, and Concatenating
# 
# There are 3 main ways of combining DataFrames together: Merging, Joining and Concatenating. In this lecture we will discuss these 3 methods with examples.
# 
# ____

# ### Example DataFrames

# In[21]:


import pandas as pd


# In[24]:


# creating data fram 1
df1 = pd.DataFrame({'A': ['A0', 'A1', 'A2', 'A3'],
                        'B': ['B0', 'B1', 'B2', 'B3'],
                        'C': ['C0', 'C1', 'C2', 'C3'],
                        'D': ['D0', 'D1', 'D2', 'D3']},
                        index=[0, 1, 2, 3])


# In[25]:


# creating data frame 2
df2 = pd.DataFrame({'A': ['A4', 'A5', 'A6', 'A7'],
                        'B': ['B4', 'B5', 'B6', 'B7'],
                        'C': ['C4', 'C5', 'C6', 'C7'],
                        'D': ['D4', 'D5', 'D6', 'D7']},
                         index=[4, 5, 6, 7]) 


# In[26]:


# crating dataframe 3
df3 = pd.DataFrame({'A': ['A8', 'A9', 'A10', 'A11'],
                        'B': ['B8', 'B9', 'B10', 'B11'],
                        'C': ['C8', 'C9', 'C10', 'C11'],
                        'D': ['D8', 'D9', 'D10', 'D11']},
                        index=[8, 9, 10, 11])


# In[27]:


df1


# In[28]:


df2


# In[29]:


df3


# ## Concatenation
# 
# Concatenation basically glues together DataFrames. Keep in mind that dimensions should match along the axis you are concatenating on. You can use **pd.concat** and pass in a list of DataFrames to concatenate together:

# In[30]:


pd.concat([df1,df2,df3]) # concatanating the data frames by rows (identified by columns)


# In[31]:


pd.concat([df1,df2,df3],axis=1) # concatanating data frames by columns


# _____
# ## Example DataFrames

# In[43]:


# creating 2 data frames, left and right
left = pd.DataFrame({'key': ['K0', 'K1', 'K2', 'K3'],
                     'A': ['A0', 'A1', 'A2', 'A3'],
                     'B': ['B0', 'B1', 'B2', 'B3']})
   
right = pd.DataFrame({'key': ['K0', 'K1', 'K2', 'K3'],
                          'C': ['C0', 'C1', 'C2', 'C3'],
                          'D': ['D0', 'D1', 'D2', 'D3']})    


# In[44]:


left


# In[45]:


right


# ___

# ## Merging
# 
# The **merge** function allows you to merge DataFrames together using a similar logic as merging SQL Tables together. For example:

# In[46]:


pd.merge(left,right,how='inner',on='key') # merging data frames over one common column


# Or to show a more complicated example:

# In[58]:


left = pd.DataFrame({'key1': ['K0', 'K0', 'K1', 'K2'],
                     'key2': ['K0', 'K1', 'K0', 'K1'],
                        'A': ['A0', 'A1', 'A2', 'A3'],
                        'B': ['B0', 'B1', 'B2', 'B3']})
    
right = pd.DataFrame({'key1': ['K0', 'K1', 'K1', 'K2'],
                               'key2': ['K0', 'K0', 'K0', 'K0'],
                                  'C': ['C0', 'C1', 'C2', 'C3'],
                                  'D': ['D0', 'D1', 'D2', 'D3']})


# In[59]:


left


# In[60]:


right


# In[63]:


pd.merge(left, right, on=['key1', 'key2']) # merging on common elements over the keys (inner join) : Intersection


# In[64]:


pd.merge(left, right, on=['key2', 'key1']) 


# In[65]:


pd.merge(left, right, how='outer', on=['key1', 'key2']) # merging like Union


# In[66]:


pd.merge(left, right, how='right', on=['key1', 'key2']) # merging like right Union


# In[67]:


pd.merge(left, right, how='left', on=['key1', 'key2']) # merging like left Union


# ## Joining
# Joining is a convenient method for combining the columns of two potentially differently-indexed DataFrames into a single result DataFrame.

# In[72]:


left1 = pd.DataFrame({'A': ['A0', 'A1', 'A2'],
                     'B': ['B0', 'B1', 'B2']},
                      index=['K0', 'K1', 'K2']) 

right2 = pd.DataFrame({'C': ['C0', 'C2', 'C3'],
                    'D': ['D0', 'D2', 'D3']},
                      index=['K0', 'K2', 'K3'])


# In[73]:


left1


# In[74]:


right2


# In[75]:


left.join(right2) # left join


# In[77]:


right.join(left1) # right join


# In[79]:


left.join(right2, how='outer') # outer join (like SQL)


# # Done!
