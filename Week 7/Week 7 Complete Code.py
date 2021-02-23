#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb 22 10:34:41 2021

@author: mollybair
"""

import pandas as pd

def csv_to_df(filename, keep):
    """
    This function takes a csv file and returns a pandas dataframe

    Parameters
    ----------
    filename : string
        name of csv file
    keep : list of strings
        names of columns to keep from file

    Returns
    -------
    df : pandas dataframe

    """
    df = pd.read_csv(filename, usecols=keep)
    return df

def rename_variables(df, current_names, new_names):
    """
    This function renames all variables in a pandas dataframe

    Parameters
    ----------
    df : pandas dataframe
    current_names : list of strings
        current names of columns in df
    new_names : list of strings
        new names of columns in df

    Returns
    -------
    renamed_df : pandas df

    """
    name_dict = {}
    for i in range(0, len(current_names)):
        key = current_names[i]
        value = new_names[i]
        temp = {key:value}
        name_dict.update(temp)
    renamed_df = df.rename(columns=name_dict)
    return renamed_df

def group(df, group_var):
    """
    This function groups a dataframe by a specified variable, with summed groups

    Parameters
    ----------
    df : pandas dataframe
    group_var : string
        name of variable to group by

    Returns
    -------
    grouped : pandas dataframe

    """
    grouped = df.groupby(by=group_var).sum()
    return grouped

def count_to_pct(df, count_vars, total_count, pct_names):
    """

    Parameters
    ----------
    df : pandas dataframe
        dataframe with variable/s populated by counts
    count_vars : list of strings
        names of variables that are populated by counts
    total_count : string
        name of variable that represents total count of a category
    pct_names : list of strings
        names of new percentage variables

    Returns
    -------
    df : pandas dataframe

    """
    for i in range(0, len(count_vars)):
        value = round((df[count_vars[i]]/df[total_count])*100, 2)
        df[pct_names[i]] = value
    return df

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
    #print(ps_df.head())
    
    by_state = group(ps_df, 'state')
    #print(by_state.head())
    
    student_groups = ['aian_students', 'hispanic_students', 'black_students',\
                      'white_students', 'mr_students', 'male_students', 'female_students']
    pct_names = ['pct_aian', 'pct_black', 'pct_white', 'pct_nhpi', 'pct_mr',\
                 'pct_male', 'pct_female']
    by_state = count_to_pct(by_state, student_groups, 'total_students', pct_names)
    print(by_state.head())

main()








