### OBJECTIVE ###
# Using data on public school characteristics, determine the average student-teacher ratio by state, 
# and compare to demographic breakdown of students

### LOAD DATA ###
public_schools <- read_csv("Public_School_Characteristics_2018-19.csv")[,c("LSTATE", "MEMBER",
                                                                           "AM", "HI", "BL", "WH",
                                                                           "HP", "TR", "STUTERATIO",
                                                                           "TOTMENROL", "TOTFENROL")]
view(public_schools)

### RENAME VARIABLES ###
new_names <- c("state", "total_students", "aian_students", "hispanic_students",
               "black_students", "white_students", "nhpi_students", "multiracial_students",
               "student_teacher_ratio", "male_students", "female_students")
names(public_schools) <- new_names
view(public_schools)

### GROUP BY STATE ###
by_state <- public_schools %>%
  group_by(state) %>%
  summarize(total_students = sum(total_students, na.rm = TRUE),
            aian_students = sum(aian_students, na.rm = TRUE),
            hispanic_students = sum(hispanic_students, na.rm = TRUE),
            black_students = sum(black_students, na.rm = TRUE),
            white_students = sum(white_students, na.rm = TRUE),
            nhpi_students = sum(nhpi_students, na.rm = TRUE),
            multiracial_students = sum(multiracial_students, na.rm = TRUE),
            av_stud_teach_ratio = mean(student_teacher_ratio, na.rm = TRUE), 
            male_students = sum(male_students, na.rm = TRUE),
            female_students = sum(female_students, na.rm = TRUE))
view(by_state)

### CONVERT TO PERCENT ###
new_var_names <- c("pct_aian", "pct_hisp", "pct_black", "pct_white", "pct_nhpi", "pct_multiracial", "pct_male",
                   "pct_female")
student_groups <- c("aian_students", "hispanic_students", "black_students", "white_students", "nhpi_students",
          "multiracial_students", "male_students", "female_students")
for (i in 1:length(new_var_names)) {
  new_var <- new_var_names[i]
  current_group <- student_groups[i]
  by_state[[new_var]] <- round((by_state[[current_group]] / by_state$total_students) * 100, 2)
}
view(by_state)

