#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb 22 11:51:47 2021

@author: mollybair
"""
# OBJECTIVES
# 1: Get familiar with python functions and style
# 2: Understand basic pandas usage for data manipulation

import pandas as pd

# Load data

# Rename variables

# Group data by state

# Convert counts to percentages

def main():
    cols = ['LSTATE', 'MEMBER', 'AM', 'HI', 'BL', 'WH', 'HP', 'TR', 'STUTERATIO',\
            'TOTMENROL', 'TOTFENROL']

    
    new_col_names = ['state', 'total_students', 'aian_students', 'hispanic_students',\
                    'black_students', 'white_students', 'nhpi_students',\
                        'mr_students', 'st_ratio', 'male_students', 'female_students']

    
    student_groups = ['aian_students', 'hispanic_students', 'black_students',\
                      'white_students', 'mr_students', 'male_students', 'female_students']
    pct_names = ['pct_aian', 'pct_black', 'pct_white', 'pct_nhpi', 'pct_mr',\
                 'pct_male', 'pct_female']

