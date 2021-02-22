#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb 22 10:34:41 2021

@author: mollybair
"""

import pandas as pd

def csv_to_df(filename, keep):
    df = pd.read_csv(filename, usecols=keep)
    return df

def rename_variables(df, current_names, new_names):
    # This function takes in a dataframe, a list of the current names of variables in that
    # dataframe, and the list of new variable names
    # This function creates a dictionary that maps existing names to new names
    # It then uses that dictionary to rename the columns in the dataframe
    # https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.rename.html
    name_dict = {}
    for i in range(0, len(current_names)):
        key = current_names[i]
        value = new_names[i]
        temp = {key:value}
        name_dict.update(temp)
    renamed_df = df.rename(columns=name_dict)
    return renamed_df

def main():
    cols = ['LSTATE', 'MEMBER', 'AM', 'HI', 'BL', 'WH', 'HP', 'TR', 'STUTERATIO',\
            'TOTMENROL', 'TOTFENROL']
    ps_df = csv_to_df('Public_School_Characteristics_2018-19.csv', cols)
    #print(school_df.head())
    
    col_names = list(ps_df.columns)
    new_col_names = ['state', 'total_students', 'aian_students', 'hispanic_students',\
                    'black_students', 'white_students', 'nhpi_students',\
                        'mr_students', 'st_ratio', 'male_students', 'female_students']
    ps_df = rename_variables(ps_df, col_names, new_col_names)
    print(ps_df.head())

    
    
    


main()








