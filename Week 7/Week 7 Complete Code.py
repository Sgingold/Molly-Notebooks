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



def main():
    cols = ['LSTATE', 'MEMBER', 'AM', 'HI', 'BL', 'WH', 'HP', 'TR', 'STUTERATIO',\
            'TOTMENROL', 'TOTFENROL']
    ps_df = csv_to_df('Public_School_Characteristics_2018-19.csv', cols)
    print(school_df.head())

    
    
    


main()








